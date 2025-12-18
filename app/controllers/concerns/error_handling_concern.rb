# frozen_string_literal: true

module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from CanCan::AccessDenied, with: :access_denied
    rescue_from ArgumentError, with: :handle_argument_error
    rescue_from JWT::ExpiredSignature, with: :expire_handle
  end

  # private
  def handle_argument_error(exception)
    # Check if the exception message matches the enum error format
    if exception.message.include?('is not a valid')
      # This is a specific enum error, render a user-friendly response (HTTP 422 Unprocessable Entity or 400 Bad Request)
      render json: { error: "Invalid value provided for an enum field: #{exception.message}" },
             status: :unprocessable_entity
    else
      # This is a different, potentially unexpected, ArgumentError
      # Log the error and re-raise it for standard 500 error handling, or handle it differently
      Rails.logger.error("Unexpected ArgumentError: #{exception.message}")
      # Depending on your app's needs, you might want to re-raise, or render a generic 500
      raise exception
    end
  end

  def expire_handle
    render json: {
      messages: "Expired Token"
    }
  end

  def render_unprocessable_entity(exception)
    render json: {
      error: 'Validation failed',
      messages: exception.record.errors.full_messages
    }
  end

  def access_denied
    render json: { message: 'You are not authorized to perform this action.' }
  end

  def record_not_found
    model_name = self.class.name.demodulize.sub('Controller', '').singularize
    render json: {
      messages: "#{model_name} doesn't Exists. "
    }
  end

end
