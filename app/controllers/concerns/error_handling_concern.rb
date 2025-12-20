# frozen_string_literal: true

module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from CanCan::AccessDenied, with: :access_denied
    rescue_from ArgumentError, with: :handle_argument_error
    rescue_from JWT::ExpiredSignature, with: :expire_handle
    rescue_from InvalidRecordError, with: :handle_invalid_record
    rescue_from IncorrectPaginationError, with: :handle_incorrect_pagination
  end

  def handle_argument_error(exception)
    if exception.message.include?('is not a valid')
      render json: { error: "Invalid value provided for an enum field: #{exception.message}" },
             status: :unprocessable_entity
    else
    Rails.logger.error("Unexpected ArgumentError: #{exception.message}")
      raise exception
    end
  end

  def handle_invalid_record(exception)
    render json: { error: "Invalid record", message: exception }
  end

  def expire_handle
    render json: { messages: "Expired Token" }
  end

  def render_unprocessable_entity(exception)
    render json: { error: 'Validation failed', messages: exception.record.errors.full_messages }
  end

  def access_denied
    render json: { message: 'You are not authorized to perform this action.' }
  end

  def record_not_found
    model_name = self.class.name.demodulize.sub('Controller', '').singularize
    render json: { messages: "#{model_name} doesn't Exists." }
  end

  def handle_incorrect_pagination(exception)
    render json: { message: "Enter page less than total page." }
  end

end
