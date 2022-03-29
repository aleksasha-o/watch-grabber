# frozen_string_literal: true

module Parsers
  class BaseParser
    PRICE_EXPRESSION = /\d+(?:,\d+)?/
    CURRENCY = 'usd'

    attr_reader :engine

    def initialize(html)
      @engine = Nokogiri::HTML(html)
    end

    def attributes
      base_attributes.merge!(additional_attributes)
    end

    # rubocop:disable Metrics/MethodLength
    def base_attributes
      {
        brand:             brand,
        model:             model,
        price:             price,
        currency:          CURRENCY,
        dial_color:        dial_color,
        case_material:     case_material,
        case_dimensions:   case_dimensions,
        bracelet_material: bracelet_material,
        movement_type:     movement_type,
        external_id:       external_id,
        image_uri:         image_uri
      }
    end
    # rubocop:enable Metrics/MethodLength

    def item_urls
      parse_links(self.class::ITEM)
    end

    def next_page?
      parse_html(self.class::NEXT_PAGE)[0].present?
    end

    private

    def parse_links(tag)
      parse_html(tag).pluck(:href)
    end

    def parse_link(tag)
      parse_links(tag)[0]
    end

    def parse_content_by_tag(tag)
      parse_html(tag).map(&:content)
    end

    def parse_html(tag)
      engine.search(tag)
    end

    def price
      parse_content_by_tag(self.class::PRICE)[0]&.scan(PRICE_EXPRESSION)&.join&.gsub(',', '')
    end
  end
end
