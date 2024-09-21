# frozen_string_literal: true

class BuildAccessToken
  include Interactor

  def call
    context.token = JWT.encode(
      { **context.payload, exp: Time.now.to_i + 40.minutes.to_i },
      ENV.fetch('HMAC_JWT_SECRET'),
      'HS256'
    )
  end
end
