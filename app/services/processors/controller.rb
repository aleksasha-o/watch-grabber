# frozen_string_literal: true

module Processors
  class Controller
    def run
      Sidekiq.redis do |redis|
        redis.set('parsing:run', true)
        redis.set('parsing:run:datetime', datetime)
      end

      HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async
    end

    def stop
      Sidekiq.redis do |redis|
        redis.del('parsing:run')
        redis.set('parsing:stop:datetime', datetime)
      end

      parsing_queue&.clear
    end

    def check
      Sidekiq.redis { |redis| redis.del('parsing:run') } if parsing_queue&.size&.zero? && parsing_worker.blank?
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
      time = Time.zone.now
      time.today? ? time.to_formatted_s(:time) : time.to_formatted_s(:short)
    end
  end
end
