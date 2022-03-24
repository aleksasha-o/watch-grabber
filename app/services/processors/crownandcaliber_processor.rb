# frozen_string_literal: true

module Processors
  class CrownandcaliberProcessor < BaseProcessor
    TAGS = [
      PAGE = '.card-title.ng-binding',
      ITEM = '.vendor'
    ].freeze

    PROTOCOL = 'https'
    HOST = 'www.crownandcaliber.com'
    PAGINATION_SELECTOR = '/collections/shop-for-watches?page='

    private

    def page_url
      "#{PROTOCOL}://#{HOST}#{PAGINATION_SELECTOR}#{@page}"
    end

    def parser
      Parsers::CrownandcaliberParser
    end

    def full_item_url(part_of_url)
      "#{PROTOCOL}:#{part_of_url}"
    end

    def model
      CrownandcaliberItem
    end
  end
end
