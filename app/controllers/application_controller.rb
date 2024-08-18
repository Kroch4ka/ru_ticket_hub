class ApplicationController < ActionController::Base
  rescue_from StandardError do |exception|
    Rails.logger.error exception.message
    render json: { error: "Something went wrong" }, status: 500
  end

  def encode_token(payload) = JWT.encode(payload, ENV["HMAC_JWT_SECRET"])

  def decode_token
    auth_header = request.headers['Authorization']
    return unless auth_header
    token = auth_header.split(" ")[1]
    suppress(JWT::DecodeError) { JWT.decode(token, ENV["HMAC_JWT_SECRET"], true, algorithm: "HS256") }
  end
end
