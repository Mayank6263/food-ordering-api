# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  before_create :apply_coupon

  def apply_coupon
    byebug

  end

end
