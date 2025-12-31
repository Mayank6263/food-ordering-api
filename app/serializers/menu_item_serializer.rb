# frozen_string_literal: true

class MenuItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :price, :description, :restaurant_id
  attributes :valid_till, :discount, if: Proc.new { |record| record.valid_till.present? && record.discount.present? }
  # attribute :discount, if: Proc.new { |record| record.discount.present? }
end
