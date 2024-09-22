# frozen_string_literal: true

module V1
  class Companies < Grape::API
    format :json

    use ActionDispatch::RemoteIp
    include Grape::Jwt::Authentication
    helpers ::Helpers::AuthHelpers

    auth :jwt

    resource :companies do
      get do
        Company.all
      end
    end
  end
end
