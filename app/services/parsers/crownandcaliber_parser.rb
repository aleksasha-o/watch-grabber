# frozen_string_literal: true

module Parsers
  class CrownandcaliberParser < BaseParser
    TAGS = [
      ITEM          = '.grid-view-item__link',
      NEXT_PAGE     = '.arrow.next:not(.disabled)',
      BRAND         = '.vendor',
      MODEL         = '.main-product-name',
      PRICE         = '//*[@id="ProductPrice-product-template"]',
      EXTERNAL_ID   = '.itemNo',
      FEATURES      = '.prod-specs div',
      DIAL          = :'dial color',
      CASE_MATERIAL = :'case material',
      DIMENSION     = :'case size',
      CASEBACK      = :'case back',
      POWER         = :'power reserve',
      LUG           = :'lug width',
      WRIST         = :'max. wrist size',
      THICKNESS     = :'case thickness'
    ].freeze

    SPACE_EXPRESSION = /\s{2,}/

    # rubocop:disable Metrics/MethodLength
    def additional_attributes
      {
        papers:         features[:papers],
        box:            features[:box],
        year:           features[:year],
        gender:         features[:gender],
        crystal:        features[:crystal],
        condition:      features[:condition],
        caseback:       features[CASEBACK],
        power_reserve:  features[POWER],
        lug_width:      features[LUG],
        bezel_material: features[:bezel],
        manual:         features[:manual],
        max_wrist_size: features[WRIST],
        case_thickness: features[THICKNESS]
      }
    end
    # rubocop:enable Metrics/MethodLength

    private

    def brand
      parse_content_by_tag(BRAND)[0]
    end

    def model
      parse_content_by_tag(MODEL)[0]
    end

    def price
      parse_content_by_tag(self.class::PRICE)[0]&.scan(PRICE_EXPRESSION)&.join&.gsub(',', '')
    end

    def dial_color
      features[DIAL]
    end

    def case_material
      features[CASE_MATERIAL]
    end

    def case_dimensions
      features[DIMENSION]
    end

    def bracelet_material
      features[:bracelet]
    end

    def movement_type
      features[:movement]
    end

    def external_id
      parse_content_by_tag(self.class::EXTERNAL_ID)[0]
    end

    def image_uri
      parse_html('.slider--item img')[0]&.values&.first
    end

    def features
      @features ||= parse_html(FEATURES)
                    .each { |item| item.children&.[](3)&.children&.[](1)&.remove }
                    .map(&:content)
                    .map { |str| str.split('- ', 2) }
                    .reject { |pair| pair.size < 2 }
                    .to_h do |key, value|
        [key&.strip&.downcase&.to_sym,
         value&.strip&.gsub("\n", '')&.gsub(SPACE_EXPRESSION, ' ')]
      end
    end
  end
end
