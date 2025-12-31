# frozen_string_literal: true

class OrderItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :order_id, :menu_item_id

  # attribute :id, &:order

  # belongs_to :menu_items
  # belongs_to :order_items
end
