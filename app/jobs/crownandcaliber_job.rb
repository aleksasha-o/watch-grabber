# frozen_string_literal: true

class CrownandcaliberJob
  include Sidekiq::Job
  sidekiq_options queue: :parsing

  def perform
    Processors::CrownandcaliberProcessor.call
  end
end
