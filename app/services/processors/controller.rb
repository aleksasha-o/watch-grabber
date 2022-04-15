# frozen_string_literal: true

module Processors
  class Controller
    def run
      Redis.current.set('parsing:run', true)
      Redis.current.set('parsing:run:datetime', datetime)

      HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async
    end

    def stop
      Redis.current.del('parsing:run')
      Redis.current.set('parsing:stop:datetime', datetime)

      parsing_queue&.clear
    end

    def check
      Redis.current.del('parsing:run') if parsing_queue&.size&.zero? && parsing_worker.blank?
    end

    private

    def parsing_worker
      Sidekiq::Workers.new.each do |*, work|
        return work if work['queue'] == 'parsing'
      end
    end

    def parsing_queue
      Sidekiq::Queue.all.find { |queue| queue.name == 'parsing' }
    end

    def datetime
      Time.zone.now.to_formatted_s(:short)
    end
  end
end
