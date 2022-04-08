# frozen_string_literal: true

module Processors
  class ShopHodinkeeProcessor < BaseProcessor
    TAGS = [
      PAGE = '.tw-pc',
      ITEM = '.tw-pc'
    ].freeze

    HOST = 'https://shop.hodinkee.com'
    PAGINATION_SELECTOR = '/collections/watches?page='

    private

    def page_url
      "#{HOST}#{PAGINATION_SELECTOR}#{@page}"
    end

    def parser
      Parsers::ShopHodinkeeParser
    end

    def full_item_url(path)
      "#{HOST}#{path}"
    end

    def model
      HodinkeeItem
    end
  end
end
