# frozen_string_literal: true

module Filters
  class Items
    def initialize(params:)
      @params = params
    end

    def self.filter(params:)
      new(params: params).filter
    end

    def filter
      @items = Item.all

      search_items
      sort_items

      @items
    end

    private

    def search_items
      @items = @items.by_brands(@params[:brands])
      @items = @items.by_model(@params[:model])
      @items = @items.min_max_price(min_price: @params[:price_gteq], max_price: @params[:price_lteq])
      @items = @items.by_dial_color(@params[:dial_color])
      @items = @items.by_case_material(@params[:case_material])
      @items = @items.by_case_dimensions(@params[:case_dimensions])
      @items = @items.by_bracelet_material(@params[:bracelet_material])
      @items = @items.by_movement_type(@params[:movement_type])
    end

    def sort_items
      case @params[:sort]
      when 'brandASC'
        @items = @items.ordered_by_brand_asc
      when 'brandDESC'
        @items = @items.ordered_by_brand_desc
      when 'priceASC'
        @items = @items.ordered_by_price_asc
      when 'priceDESC'
        @items = @items.ordered_by_price_desc
      end
    end
  end
end
