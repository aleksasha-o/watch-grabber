# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :count_items

  private

  def count_items
    @item_numbers = Item.count
  end
end
