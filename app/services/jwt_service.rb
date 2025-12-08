# frozen_string_literal: true

# app/services/jwt_service.rb
class JwtService
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 1.year.from_now)
    user = User.find_by(id: payload[:user_id])
    payload[:jti] = user.jti
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    body = HashWithIndifferentAccess.new(decoded)
    user = User.find_by(id: body[:user_id])

    return nil unless user && user.jti == body[:jti]

    body
  rescue JWT::ExpiredSignature
    raise JWT::ExpiredSignature
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end
end
