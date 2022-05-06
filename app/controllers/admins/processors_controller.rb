# frozen_string_literal: true

module Admins
  class ProcessorsController < ApplicationController
    before_action :authenticate_admin!

    def index
      @redis = Redis.current
    end

    def create
      Processors::Controller.new.run

      redirect_to admins_processors_path, notice: t('processors.start')
    end

    def destroy
      Processors::Controller.new.stop

      redirect_to admins_processors_path, notice: t('processors.stop')
    end
  end
end
