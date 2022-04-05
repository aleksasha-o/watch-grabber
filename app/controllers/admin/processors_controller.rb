# frozen_string_literal: true

module Admin
  class ProcessorsController < ApplicationController
    def create
      # HodinkeeJob.perform_async
      CrownandcaliberJob.perform_async
      BobswatchesJob.perform_async

      redirect_to admin_processors_path, notice: t('processors.start')
    end
  end
end
