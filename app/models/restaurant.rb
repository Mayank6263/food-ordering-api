# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :menu_items
end
