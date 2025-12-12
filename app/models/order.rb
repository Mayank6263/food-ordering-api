# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  enum status: { pending: 0, ordered: 1, delivered: 2, cancel: 3 }
end
