# frozen_string_literal: true

class CheckingJob
  include Sidekiq::Job

  sidekiq_options queue: :checking

  def perform
    Processors::Controller.new.check
  end
end
