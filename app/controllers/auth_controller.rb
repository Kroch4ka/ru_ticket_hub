# frozen_string_literal: true

class AuthController < ApplicationController
  def login
    user = User.authenticate_by(login_params)
    if user
      render json: { token: encode_token({ user_id: user.id }) }
    else
      render json: { error: { message: "email or password is not valid" } }
    end
  end

  def sign_up
    password = sign_up_params[:password]
    confirmation_password = sign_up_params[:password_confirmation]
    if password != confirmation_password
      render json: { error: { message: "password confirmation doesn't match" } }, status: :forbidden
    else
      user = User.create!(email: sign_up_params[:email], password: sign_up_params[:password])
      render json: { token: encode_token({ user_id: user.id }) }
    end
  end

  def logout

  end

  private

  def login_params
    params.permit("email", "password")
  end

  def sign_up_params
    params.permit("email", "password", "password_confirmation")
  end
end
