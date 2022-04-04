# frozen_string_literal: true

module Admin
  class ProcessorsController < ApplicationController
    def create
      HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async

      redirect_to admin_processors_path, notice: t('processors.start')
    end

    def destroy
      Sidekiq::Workers.new.each do |process_id, *|
        process = Sidekiq::Process.new('identity' => process_id)
        process.stop!
      end

      Sidekiq::Queue.all.each(&:clear)
      Sidekiq::RetrySet.new&.clear
      Sidekiq::ScheduledSet.new&.clear

      redirect_to admin_processors_path, notice: t('processors.stop')
    end
  end
end
