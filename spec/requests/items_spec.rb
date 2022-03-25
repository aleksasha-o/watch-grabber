# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Parsers', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get '/items/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/items/create'
      expect(response).to have_http_status(:success)
    end
  end
end
