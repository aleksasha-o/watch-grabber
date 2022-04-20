# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @data = Items::Index.new(params[:q])
  end
end
