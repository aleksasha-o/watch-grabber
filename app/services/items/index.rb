# frozen_string_literal: true

module Items
  class Index
    def initialize(params)
      @params = params
    end

    def items
      return @items if @items

      @items = Filters::Items.filter(params: @params)
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
  end
end
