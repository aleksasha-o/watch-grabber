# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :count_items

  private

  def count_items
    @item_numbers = Redis.new.get('items_number') || 0
  end
end
