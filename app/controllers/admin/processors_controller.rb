# frozen_string_literal: true

module Admin
  class ProcessorsController < ApplicationController
    def create
      Processors::Run.call

      redirect_to admin_processors_path, notice: t('processors.start')
    end

    def destroy
      Processors::Stop.call

      redirect_to admin_processors_path, notice: t('processors.stop')
    end
  end
end
