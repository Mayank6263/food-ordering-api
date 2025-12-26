# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  has_many :orders, dependent: :destroy
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :password,
  format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}\z/,
  message: 'password must be 6 characters, include one uppercase, lowercase letter, and number' }
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,  :confirmable
  enum role: { customer: 0, admin: 1, seller: 2, driver: 3 }


  # protected
  # def confirmation_required?
  #   false
  # end
end
