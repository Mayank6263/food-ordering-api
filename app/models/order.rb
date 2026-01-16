# frozen_string_literal: true

class Order < ApplicationRecord
  STATUS_MESSAGES = {
    'pending'   => 'Is Yet to Ordered',
    'ordered'   => 'is on way',
    'delivered'   => 'Delivered',
    'cancelled'    => 'Cancelled'
  }.freeze

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  enum status: { pending: 0, ordered: 1, delivered: 2, cancelled: 3 }
  before_save :validate_status_attribute, on: :update
  # before_create :cr, on: :create
  # before_commit :cmt, on: :create



  private

  # def cr
  #   byebug
  # end

  # def cmt
  #   byebug
  # end

  def validate_status_attribute
    if status_was == 'deliver' || status_was == 'cancel'
      raise InvalidRecordError, "Order cannot be edited once delivered or cancelled."
    end
    update_total
  end

  def update_total
    return unless status == "ordered"
    if menu_items.first.discount.present? && menu_items.first.valid_till.present?
      total = self.order_items.joins(:menu_item).sum('quantity * (price - discount)')
    else
      total = self.order_items.joins(:menu_item).sum('quantity * price')
    end
    self.total_amount = total

    DeliverOrderJob.set(wait: 1.minutes).perform_later(self)
  end
end


