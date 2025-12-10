# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      # before_action :configure_sign_up_params, only: [:create]
      # before_action :configure_account_update_params, only: [:update]
      skip_before_action :authenticate_user
      # GET /resource/sign_up
      # def new
      #   super
      # end

      # POST /resource
      def create
        @user = User.new user_params

        if @user.save!
          token = JwtService.encode(user_id: @user.id)
          message = { messages: 'Sign Up Successfully', status: :ok, token: token }
          render json: UserSerializer.new(@user, meta: message)
        else
          render json: { messages: 'Sign Up Failed', status: :unprocessable_entity }
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :name, :password, :role)
      end

      # GET /resource/edit
      # def edit
      #   super
      # end

      # PUT /resource
      # def update
      #   super
      # end

      # DELETE /resource
      # def destroy
      #   super
      # end

      # GET /resource/cancel
      # Forces the session data which is usually expired after sign
      # in to be expired now. This is useful if the user wants to
      # cancel oauth signing in/up in the middle of the process,
      # removing all OAuth session data.
      # def cancel
      #   super
      # end

      # protected

      # # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_up_params
      #   params.require(:user).permit(:email, :password)
      # end

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_account_update_params
      #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
      # end

      # The path used after sign up.
      # def after_sign_up_path_for(resource)
      #   super(resource)
      # end

      # The path used after sign up for inactive accounts.
      # def after_inactive_sign_up_path_for(resource)
      #   super(resource)
      # end
    end
  end
end
