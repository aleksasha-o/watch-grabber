# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @data = CartItems::Index.new(current_user)
  end

  def create
    CartItem.create(item_id: params[:item_id], user_id: params[:user_id])

    redirect_to items_path, notice: t('cart.add')
  end

  def destroy
    CartItem.find_by(item_id: params[:item_id]).destroy!

    redirect_to cart_items_path, notice: t('cart.delete')
  end
end
