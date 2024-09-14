# frozen_string_literal: true

class Accounts < Grape::API
  format :json

  use ActionDispatch::RemoteIp
  include Grape::Jwt::Authentication

  helpers ::Helpers::AuthHelpers

  resource :accounts do
    params do
      requires :password, type: String
      requires :password_confirmation, type: String
      requires :email, type: String
    end
    post 'sign_up' do
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
    post 'log_in' do
      declared_params = declared(params)
      result = LoginByPassword.call(**declared_params, ip_address: client_ip)
      if result.success?
        { token: result.token }
      else
        error! result.message, 401
      end
    end

    namespace :reset_password do
      params do
        requires :email, type: String
      end
      post 'request' do
        declared_params = declared(params)
        result = SendResetPasswordToken.call(**declared_params)
        if result.success?
          { message: 'Recovery email sent successfully' }
        else
          error! result.message, 400
        end
      end

      params do
        requires :reset_password_token, type: String
      end
      post 'confirm' do
        declared_params = declared(params)
        result = ConfirmResetPasswordToken.call(**declared_params)
        if result.success?
          { message: 'Confirmation is success!' }
        else
          error! result.message, 400
        end
      end

      params do
        requires :reset_password_token, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post 'finalize' do
        declared_params = declared(params)
        result = FinalizeResetPassword.call(**declared_params)
        if result.success?
          { message: 'Confirmation is success!' }
        else
          error! result.message, 400
        end
      end
    end

    namespace do
      auth :jwt
      post 'log_out' do
        AccessToken.find_by(token: context.token)&.destroy
        { message: 'Logged out successfully' }
      end
    end
  end
end
