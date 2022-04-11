# frozen_string_literal: true

require 'sidekiq-scheduler'

class CheckingJob
  include Sidekiq::Worker
  sidekiq_options queue: :checking

  def perform
    Processors::Controller.new.check
  end
end
