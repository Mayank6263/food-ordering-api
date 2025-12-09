# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class RestaurantsControllerTest < ActionDispatch::IntegrationTest
      test 'should get index' do
        get api_v1_restaurants_index_url
        assert_response :success
      end

      test 'should get create' do
        get api_v1_restaurants_create_url
        assert_response :success
      end
    end
  end
end
