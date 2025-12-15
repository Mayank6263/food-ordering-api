# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  enum status: { pending: 0, ordered: 1, deliver: 2, cancel: 3 }
  # validate :immutable, on: :update

  # def immutable
  #   # byebug
  #   if status_changed?
  #     errors.add(:status, 'Order cannot be edited Once delivered') if @order.status == 'delivered' && params[:order][:status]
  #   end
  # end
end
