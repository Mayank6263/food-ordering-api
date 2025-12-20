# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item

  # def add_order(order_item_params)
  #   byebug
  # end
end