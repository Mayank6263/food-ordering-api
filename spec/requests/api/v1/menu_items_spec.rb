# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::MenuItems', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/menu_items/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/menu_items/create'
      expect(response).to have_http_status(:success)
    end
  end
end
