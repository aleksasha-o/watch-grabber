# frozen_string_literal: true

class CrownandcaliberJob
  include Sidekiq::Job

  def perform
    Processors::CrownandcaliberProcessor.call
  end
end
