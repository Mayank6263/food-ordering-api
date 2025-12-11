# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from CanCan::AccessDenied, with: :access_denied 
  rescue_from ActionController::RoutingError, with: :route_not_found 
  rescue_from ArgumentError, with: :handle_argument_error 
  rescue_from ActionController::ParameterMissing, with: :handle_params_missing
  rescue_from AbstractController::ActionNotFound, with: :action_not_found

  private

  def authenticate_user
    token = request.headers['token']
    if token.blank?
      render json: { message: 'Token missing' }, status: :unauthorized and return
    end

    decoded = JwtService.decode(token)
    render(json: { message: 'Invalid or expired token' }, status: :unauthorized) and return if decoded.nil?

    @current_user = User.find_by(id: decoded['user_id'])
    render(json: { message: 'Invalid user' }, status: :unauthorized) and return unless @current_user
  end

  # -----------------------
  # EXCEPTION HANDLERS
  # -----------------------

  def handle_argument_error(exception)
    if exception.message.include?("is not a valid")
      render json: { error: exception.message }, status: :unprocessable_entity
    else
      Rails.logger.error("Unexpected ArgumentError: #{exception.message}")
      raise exception
    end
  end

  def handle_params_missing(exception)
    render json: {
      error: "Parameters missing",
      message: exception.message
    }, status: :bad_request
  end

  def action_not_found(exception)
    render json: { message: 'vdsfjkldsfkd' }
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: 'Validation failed',
      messages: exception.record.errors.full_messages
    }, status: :unprocessable_entity
  end

  def access_denied(exception)
    render json: { message: exception.message }, status: :forbidden
  end

  def route_not_found(exception)
    render json: { 
      error: exception.message,
      message: "Check your route."
    }, status: :not_found
  end

  def record_not_found(exception)
    render json: { message: exception.message }, status: :not_found
  end
end
