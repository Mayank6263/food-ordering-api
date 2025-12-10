# frozen_string_literal: true

module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from CanCan::AccessDenied, with: :access_denied
    rescue_from ActionController::RoutingError, with: :routing_error
  end

  # private

  def render_unprocessable_entity(exception)
    render json: {
      error: 'Validation failed',
      messages: exception.record.errors.full_messages
    }
  end

  def access_denied
    render json: { message: 'You are not authorized to perform this action.' }
  end

  def routing_error
    render json: { message: 'Check Your Routes.' }
  end

  def record_not_found
    model_name = self.class.name.demodulize.sub('Controller', '').singularize
    render json: {
      messages: "#{model_name} doesn't Exists. "
    }
  end
end
