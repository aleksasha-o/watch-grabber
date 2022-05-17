# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @data = CartItems::Index.new(current_user)
  end

  def create
    @cart_item = CartItem.create(cart_item_params)

    return redirect_to items_path, alert: t('error') if @cart_item.errors.any?

    redirect_to items_path, notice: t('cart.add')
  end

  def destroy
    CartItem.find_by(item_id: params[:item_id]).destroy!

    redirect_to cart_items_path, notice: t('cart.delete')
  end

  private

  def cart_item_params
    params.permit(:item_id, :user_id)
  end
end
