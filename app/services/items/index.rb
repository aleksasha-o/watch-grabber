# frozen_string_literal: true

module Items
  class Index
    def initialize(params)
      @params = params
    end

    def items
      return @items if @items

      @items = Item.all

      search_items
      sort_items

      @items
    end

    def brands_for_select
      Item.pluck(:brand).each { |brand| brand.humanize.capitalize }.uniq.sort
    end

    def default_min_price
      Item.pluck(:price)&.min&.round
    end

    def default_max_price
      Item.pluck(:price)&.max&.round
    end

    private

    def search_items
      @items = @items.by_brands(@params[:brands]) if @params[:brands].present?
      @items = @items.by_model(@params[:model]) if @params[:model].present?
      @items = @items.min_max_price(@params[:price_gteq], @params[:price_lteq]) if @params[:price_gteq].present?
      @items = @items.by_dial_color(@params[:dial_color]) if @params[:dial_color].present?
      @items = @items.by_case_material(@params[:case_material]) if @params[:case_material].present?
      @items = @items.by_case_dimensions(@params[:case_dimensions]) if @params[:case_dimensions].present?
      @items = @items.by_bracelet_material(@params[:bracelet_material]) if @params[:bracelet_material].present?
      @items = @items.by_movement_type(@params[:movement_type]) if @params[:movement_type].present?
    end

    def sort_items
      @items = @items.ordered_by_brand_asc if @params[:sort] == 'brandASC'
      @items = @items.ordered_by_brand_desc if @params[:sort] == 'brandDESC'
      @items = @items.ordered_by_price_asc if @params[:sort] == 'priceASC'
      @items = @items.ordered_by_price_desc if @params[:sort] == 'priceDESC'
    end
  end
end
