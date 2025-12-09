# frozen_string_literal: true

class MenuItem < ApplicationRecord
  validate lambda {
             errors.add(:name, 'already exists') if !persisted? && MenuItem.exists?(name: name)
           }
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
end
