# frozen_string_literal: true

class MenuItem < ApplicationRecord
  attr_accessor :discount, :valid_till
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  before_update :add_discount, on: :create_discount


  def add_discount
    self.discount = ((self.discount*price)/100).to_i
    self.valid_till = Time.current + self.valid_till.days
  end
end
