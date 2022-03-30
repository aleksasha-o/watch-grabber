# frozen_string_literal: true

class BobswatchesJob
  include Sidekiq::Job

  def perform
    Processors::BobswatchesProcessor.call
  end
end
