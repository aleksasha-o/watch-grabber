# frozen_string_literal: true

module Processors
  class Stop
    def self.call
      new.call
    end

    def call
      update_status
      cancel_pending_jobs
    end

    private

    def update_status
      ParsingStatus.instance.update(running: false)
    end

    def cancel_pending_jobs
      Sidekiq::Queue.all.each(&:clear)
      Sidekiq::RetrySet.new&.clear
      Sidekiq::ScheduledSet.new&.clear
    end
  end
end
