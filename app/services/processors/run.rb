# frozen_string_literal: true

module Processors
  class Run
    def self.call
      new.call
    end

    def call
      Processors::ShopHodinkeeProcessor.call(page: 18)
      Processors::CrownandcaliberProcessor.call(page: 55)
      Processors::BobswatchesProcessor.call(page: 21)
    end
  end
end
