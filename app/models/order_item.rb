# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  # before_validation :apply_coupon

  # def apply_coupon
  #   # byebug
  #   # if menu_item.discount.present? && menu_item.valid_till.present?
  #   #   menu_item.price = menu_item.price - menu_item.discount
  #   # end
  # end

end
