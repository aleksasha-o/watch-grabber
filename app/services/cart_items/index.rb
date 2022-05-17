# frozen_string_literal: true

module CartItems
  class Index
    def initialize(user)
      @user = user
    end

    def items_in_cart
      Item.joins(:cart_items).where(cart_items: { user_id: @user.id })
    end

    def total_in_cart
      items_in_cart.sum(&:price)
    end
  end
end
