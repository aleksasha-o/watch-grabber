# frozen_string_literal: true

class ProcessorsController < ApplicationController
  def run
    Processors::Run.call(params[:processor_type])

    redirect_to processors_path, notice: t('processors.success')
  end
end
