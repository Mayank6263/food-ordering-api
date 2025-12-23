# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  # self.locking_column = :order_item
end
