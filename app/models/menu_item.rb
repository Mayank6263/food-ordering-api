  # frozen_string_literal: true

  class MenuItem < ApplicationRecord
    attr_accessor :valid_days
    belongs_to :restaurant
    # validate :is_valid_days_zero?, on: :update
    has_many :order_items, dependent: :destroy
    has_many :orders, through: :order_items
    before_validation :add_validity, :add_discount, if: ->{ valid_days.present? && discount.present? }
    # before_update :add_discount, on: :create_discount
    after_commit :send_discount_mail, on: :update

    # def is_valid_days_zero?
    #   byebug
    #   valid_days = valid_days.to_i.days unless valid_days.zero?
    #   raise InvalidRecordError, "Validity Cannot be zero"
    # end

    def add_discount
      self.discount = ((discount*self.price)/100).to_i
    end

    def add_validity
      self.valid_till = Time.current + valid_days
    end

    def send_discount_mail
      return unless previous_changes.key?('discount')
      SendDiscountMailJob.perform_now(self)
    end
  end
