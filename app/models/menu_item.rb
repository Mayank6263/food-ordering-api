# frozen_string_literal: true

class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  def self.search_menu
    where("name ilike ?", "%#{params[:query]}%")
  end
end
