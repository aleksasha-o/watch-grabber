# frozen_string_literal: true

module Processors
  class Controller
    def run
      Redis.new.set('parsing:run', true)

      # HodinkeeJob.perform_async
      # CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async
    end

    def stop
      Redis.new.del('parsing:run')

      Sidekiq::Queue.all.find { |queue| queue.name == 'parsing' }&.clear
    end
  end
end
