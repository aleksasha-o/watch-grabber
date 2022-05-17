# frozen_string_literal: true

module Items
  class Index
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
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

    def item_in_cart?(current_item)
      @current_user.present? && item_ids.include?(current_item.id)
    end

    private

    def item_ids
      @item_ids ||= CartItem.where(user_id: @current_user.id).pluck(:item_id)
    end
  end
end
