# frozen_string_literal: true

class Order < ApplicationRecord
  STATUS_MESSAGES = {
    'ordered'   => 'is on way',
    'delivered' => 'Delivered',
    'cancel'    => 'Cancelled'
  }.freeze


  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  enum status: { pending: 0, ordered: 1, deliver: 2, cancel: 3 }

    # STATUS_MESSAGES.fetch(status, 'yet to Order')
  # def status_message
  # end

  private

  def validate_status_attribute
    if status_was == 'deliver' || status_was == 'cancel'
      raise InvalidRecordError, "Order cannot be edited once delivered or cancelled."
    end
    update_total
  end

  def update_total
    return unless status == "ordered"

    DeliverOrderJob.set(wait: 30.minutes).perform_later(self)
    
    total = self.order_items
    .joins(:menu_item)
    .sum('quantity * price')
    self.total_amount = total
    # status_message
  end
end
