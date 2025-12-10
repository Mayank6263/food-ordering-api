# frozen_string_literal: true

class MenuitemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price, :description, :restaurant_id
end
