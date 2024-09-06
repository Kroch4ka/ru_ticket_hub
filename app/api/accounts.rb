# frozen_string_literal: true

class Accounts < Grape::API
  format :json

  include Grape::Jwt::Authentication

  helpers ::Helpers::AuthHelpers

  resource :accounts do
    params do
      requires :password, type: String
      requires :password_confirmation, type: String
      requires :email, type: String
    end
    post "sign_up" do
      declared_params = declared(params)
      result = SignupByPassword.call(**declared_params)
      if result.success?
        { token: result.token }
      else
        error! result.message, 401
      end
    end

    params do
      requires :email, type: String
      requires :password, type: String
    end
    post "log_in" do
      declared_params = declared(params)
      result = LoginByPassword.call(**declared_params)
      if result.success?
        { token: result.token }
      else
        error! result.message, 401
      end
    end

    namespace do
      auth :jwt

      post "log_out" do
        TokenStorage.find_by(token: context.token)&.destroy
        { message: "Logged out successfully" }
      end
    end
  end
end
