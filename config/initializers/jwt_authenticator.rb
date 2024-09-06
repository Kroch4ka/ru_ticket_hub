# frozen_string_literal: true

Grape::Jwt::Authentication.configure do |conf|
  conf.jwt_verification_key = proc do
    ENV.fetch('HMAC_JWT_SECRET')
  end

  conf.jwt_options = proc do
    { algorithm: 'HS256' }
  end

  conf.authenticator = proc do |token|
    jwt = Keyless::Jwt.new(token)
    in_storage = !!TokenStorage.find_by(token:, account_id: jwt.payload.account_id)
    jwt.valid? && in_storage
  end
end
