class ApplicationController < ActionController::API
	before_action :authenticate_user
  rescue_from ActiveRecord::RecordInvalid { |x| "#{x} Invalid Password"}

	def authenticate_user
	    token = request.headers["token"]
	    if token.present?
	      decoded = JwtService.decode(token)

	      if decoded.nil?
	        render json: { message: "Invalid or expired token" }, status: :unauthorized and return
	      end

	      id = decoded["user_id"]
	      @current_user = User.find_by(id: id)

	      unless @current_user
	        render json: { message: "Invalid user" }, status: :unauthorized and return
	      end

	    else
	      render json: { message: "Token missing" }, status: :unauthorized
	    end
	 end
end
