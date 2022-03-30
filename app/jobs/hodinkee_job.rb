# frozen_string_literal: true

class HodinkeeJob
  include Sidekiq::Job

  def perform
    Processors::ShopHodinkeeProcessor.call
  end
end
