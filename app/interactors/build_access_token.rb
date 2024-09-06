# frozen_string_literal: true

class BuildAccessToken
  include Interactor

  EXPIRATION_PERIOD = Time.now.to_i + 15 * 3600

  def call
    context.token = JWT.encode(
      { **context.payload, exp: EXPIRATION_PERIOD },
      ENV.fetch("HMAC_JWT_SECRET"),
      "HS256"
    )
  end
end
