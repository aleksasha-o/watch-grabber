# frozen_string_literal: true

module Items
  class Index
    def initialize(params, user)
      @params = params
      @user = user
    end

    def items
      return @items if @items

      @items = Filters::Items.filter(params: @params)
    end

    def brands_for_select
      Item.pluck(:brand).each { |brand| brand.humanize.capitalize }.uniq.sort
    end

    def default_min_price
      Item.minimum(:price)
    end

    def default_max_price
      Item.maximum(:price)
    end

    def in_cart?(current_item)
      @user.present? && item_ids.include?(current_item.id)
    end

    private

    def item_ids
      @item_ids ||= CartItem.where(user_id: @user.id).pluck(:item_id)
    end
  end
end
