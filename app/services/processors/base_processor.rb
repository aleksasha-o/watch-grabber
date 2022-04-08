# frozen_string_literal: true

module Processors
  class BaseProcessor
    attr_accessor :page

    def initialize(page: 1)
      @page = page
    end

    def self.call(page: 1)
      new(page: page).call
    end

    def call
      visit_page
      parse_item_links
      visit_and_parse_items

      return browser.exit_browser if stopping? || @page >= 2 || !page_parser.next_page?

      @page += 1
      call
    end

    private

    def browser
      @browser ||= Browser.new
    end

    def visit_page
      @page_content = browser.visit(url: page_url, tag: self.class::PAGE)
    end

    def parse_item_links
      @item_links = page_parser.item_urls
    end

    def page_parser
      parser.new(@page_content)
    end

    def visit_and_parse_items
      @item_links.each do |item_url|
        break if stopping?

        content = visit_item(item_url)
        attributes = parse_item_attributes(content)

        model.find_or_initialize_by(external_id: attributes[:external_id])
             .update(**attributes)
      end
    end

    def visit_item(part_of_url)
      browser.visit(url: full_item_url(part_of_url), tag: self.class::ITEM)
    end

    def parse_item_attributes(item_content)
      parser.new(item_content).attributes
    end

    def stopping?
      redis.get('parsing:run').blank?
    end

    def redis
      @redis ||= Redis.new
    end
  end
end
