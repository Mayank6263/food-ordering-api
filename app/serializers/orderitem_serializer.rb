# frozen_string_literal: true

class OrderitemSerializer
  include FastJsonapi::ObjectSerializer
  attributes id, quantity, order_id, menu_item_id
end
