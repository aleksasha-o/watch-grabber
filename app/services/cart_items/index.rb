# frozen_string_literal: true

module CartItems
  class Index
    def initialize(current_user)
      @current_user = current_user
    end

    def items_in_cart
      CartItem.all.map do |cart_item|
        Item.find(cart_item.item_id) if cart_item.user_id.to_i == @current_user.id
      end
    end

    def total_in_cart
      items_in_cart.sum(&:price)
    end
  end
end
