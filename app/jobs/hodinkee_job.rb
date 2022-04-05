# frozen_string_literal: true

class HodinkeeJob
  include Sidekiq::Job
  sidekiq_options queue: :parsing

  def perform
    Processors::ShopHodinkeeProcessor.call
  end
end
