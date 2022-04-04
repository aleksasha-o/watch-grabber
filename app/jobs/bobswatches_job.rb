# frozen_string_literal: true

class BobswatchesJob
  include Sidekiq::Job
  sidekiq_options queue: :parsing

  def perform
    Processors::BobswatchesProcessor.call
  end
end
