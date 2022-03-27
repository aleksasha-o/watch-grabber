# frozen_string_literal: true

module Admin
  class ProcessorsController < ApplicationController
    def create
      Processors::Run.call
      redirect_to admin_processors_path, notice: t('processors.success')
    end
  end
end
