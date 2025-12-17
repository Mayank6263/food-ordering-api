# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :menu_items, dependent: :destroy
  validates :name, :address, presence: true
  validate lambda {
             errors.add(:name, 'already exists') if !persisted? && Restaurant.exists?(name: name)
           }

  # geocoded_by :address         # tells Geocoder which column to geocode
  # after_validation :geocode, if: :address_changed?   # auto-fetch lat/lng

  # # Optional helper to build address string from IP location
  # def self.create_from_ip(name, ip)
  #   loc = Geocoder.lookup_ip(ip)
  #   address = loc ? [loc[:city], loc[:state], loc[:country]].compact.join(', ') : nil

  #   create(
  #     name: name,
  #     address: address,
  #     latitude: loc ? loc[:latitude] : nil,
  #     longitude: loc ? loc[:longitude] : nil
  #   )
  # end
end
