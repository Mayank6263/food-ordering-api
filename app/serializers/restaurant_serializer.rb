# frozen_string_literal: true

class RestaurantSerializer
  include FastJsonapi::ObjectSerializer
  attributes id, name, address
end
