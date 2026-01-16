# frozen_string_literal: true
require 'stripe'
Stripe.api_key = 'Your Secret Key'

class ApplicationController < ActionController::Base
  include ErrorHandling

  before_action :authenticate_user
  skip_before_action :authenticate_user, only: :new


  def current_user
    @current_user
  end

  private

  def authenticate_user
    token = request.headers['token']
    if token.present?
      decoded = JwtService.decode(token)

      render json: { message: 'Invalid or expired token' }, status: :unauthorized and return if decoded.nil?

      id = decoded['user_id']
      @current_user = User.find_by(id: id)

      render json: { message: 'Invalid user' }, status: :unauthorized and return unless @current_user

    else
      render json: { message: 'Token missing' }, status: :unauthorized
    end
  end
end
