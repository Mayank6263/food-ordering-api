# frozen_string_literal: true

class MenuitemSerializer
  include FastJsonapi::ObjectSerializer
  attributes id, name, price, description, restaurant_id
end
