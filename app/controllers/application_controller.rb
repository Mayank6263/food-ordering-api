# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandlingConcern
  before_action :authenticate_user

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

  def current_user
    @current_user
  end
end
