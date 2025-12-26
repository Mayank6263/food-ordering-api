class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :authenticate_user
  def show
   self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render json: { message: 'Your email has been successfully confirmed.', status: :ok }
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
