# frozen_string_literal: true

class Companies < Grape::API
  format :json

  use ActionDispatch::RemoteIp
  include Grape::Jwt::Authentication
  helpers ::Helpers::AuthHelpers

  auth :jwt

  resource :companies do
    params do
      requires :id, type: Integer
    end
    get ":id" do; end
  end
end
