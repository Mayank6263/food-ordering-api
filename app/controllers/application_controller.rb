# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  def render_unprocessable_entity(exception)
    render json: {
      error: 'Validation failed',
      messages: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def record_not_found
    model_name = self.class.name.demodulize.sub('Controller', '').singularize
    render json: {
      messages: "#{model_name} doesn't Exists. "
    }
  end
end
