# frozen_string_literal: true

module Processors
  class Run
    def self.call
      new.call
    end

    def call
      update_status
      run_jobs
    end

    private

    def update_status
      ParsingStatus.instance.update(running: true)
    end

    def run_jobs
      HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async
    end
  end
end

