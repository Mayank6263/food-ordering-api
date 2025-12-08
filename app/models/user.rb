# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :orders
  validates :email, uniqueness: true
  validates :name, presence: true
  validates :password,
            format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{12,}\z/,
                      message: 'password must be at least 12 characters long and include at least one uppercase letter, one lowercase letter, and one number' }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
