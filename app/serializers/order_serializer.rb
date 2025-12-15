# frozen_string_literal: true

class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_amount, :status, :user_id, :order_items, :menu_items

  # has_many :menu_items, serializer: MenuitemSerializer
end
