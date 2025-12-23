# frozen_string_literal: true

class Order < ApplicationRecord
  STATUS_MESSAGES = {
    'pending'   => 'Is Yet to Ordered',
    'ordered'   => 'is on way',
    'deliver'   => 'Delivered',
    'cancel'    => 'Cancelled'
  }.freeze

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  enum status: { pending: 0, ordered: 1, delivered: 2, cancelled: 3 }
  before_save :validate_status_attribute, on: :update

  private

  def validate_status_attribute
    byebug
    if status_was.in?('deliver', 'cancel')
      raise InvalidRecordError, "Order cannot be edited once delivered or cancelled."
    end
    update_total
  end

  def update_total
    return unless status == "ordered"

    DeliverOrderJob.set(wait: 1.minutes).perform_later(self)

        total = self.order_items
    .joins(:menu_item)
    .sum('quantity * price')
    self.total_amount = total
  end
end
