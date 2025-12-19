# frozen_string_literal: true

class OrderitemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :order_id, :menu_item_id

  # belongs_to :menu_items
  # belongs_to :order_items
end
