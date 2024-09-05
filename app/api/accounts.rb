# frozen_string_literal: true

class Accounts < Grape::API
  format :json

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
        status 200
      else
        error! result.message, 401
      end
    end
  end
end
