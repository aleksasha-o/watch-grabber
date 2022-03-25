# frozen_string_literal: true

module Processors
  class Run
    SHOP_HODINKEE   = 'shop_hodinkee'
    CROWNANDCALIBER = 'crownandcaliber'
    BOBSWATCHES     = 'bobswatches'

    def initialize(type)
      @type = type
    end

    def self.call(type)
      new(type).call
    end

    def call
      case @type
      when SHOP_HODINKEE   then Processors::ShopHodinkeeProcessor.call(page: 18)
      when CROWNANDCALIBER then Processors::CrownandcaliberProcessor.call
      when BOBSWATCHES     then Processors::BobswatchesProcessor.call
      end
    end
  end
end
