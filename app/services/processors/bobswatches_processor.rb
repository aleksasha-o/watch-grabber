# frozen_string_literal: true

module Processors
  class BobswatchesProcessor < BaseProcessor
    TAGS = [
      PAGE = '.product-title',
      ITEM = '.price'
    ].freeze

    HOST = 'https://www.bobswatches.com/'
    PAGINATION_SELECTOR = 'shop?page='

    private

    def page_url
      "#{HOST}#{PAGINATION_SELECTOR}#{@page}"
    end

    def parser
      Parsers::BobswatchesParser
    end

    def full_item_url(path)
      "#{HOST}#{path}"
    end

    def model
      BobswatchesItem
    end
  end
end
