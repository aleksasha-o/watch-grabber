# frozen_string_literal: true

module Processors
  class Controller
    def run
      redis.set('parsing:run', true)
      redis.set('parsing:run:datetime', datetime)

      HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async
    end

    def stop
      redis.del('parsing:run')
      redis.set('parsing:stop:datetime', datetime)

      Sidekiq::Queue.all.find { |queue| queue.name == 'parsing' }&.clear
    end

    private

    def redis
      Redis.new
    end

    def datetime
      time = Time.zone.now
      time.today? ? time.to_formatted_s(:time) : time.to_formatted_s(:short)
    end
  end
end
