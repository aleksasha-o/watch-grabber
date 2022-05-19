# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @data = Items::Index.new(params, current_user)
  end
end
