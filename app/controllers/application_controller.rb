# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandlingConcern
  before_action :authenticate_user

  # before_action do
  #   resource = controller_name.singularize.to_sym
  #   method = "#{resource}_params"
  #   params[resource] &&= send(method) if respond_to?(method, true)
  # end
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

  attr_reader :current_user
end
