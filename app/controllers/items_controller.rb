# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @items = Item.order(:brand)
  end
end
