# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :authenticate_user
      before_action :sign_in_params, only: :create
      before_action :load_user, only: :create

      def create
        if @user&.valid_password?(sign_in_params[:password])
          token = JwtService.encode(user_id: @user.id)
          sign_in('user', @user)
          message = { message: 'Signed In Successfully.', token: token }
          render json: UserSerializer.new(@user, meta: message)
        else
          render json: { message: 'Invalid Password.' }
        end
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end

      def load_user
        @user = User.find_for_database_authentication(email: sign_in_params[:email])
        render json: { messages: 'Cannot find user', status: :not_found, data: {} } unless @user
      end

      # GET /resource/sign_in
      # def new
      #   super
      # end

      # POST /resource/sign_in
      # def create
      #   super
      # end

      # DELETE /resource/sign_out
      # def destroy
      #   super
      # end

      # protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_in_params
      #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
      # end
    end
  end
end
