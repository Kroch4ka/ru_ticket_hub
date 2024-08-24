# frozen_string_literal: true

class AuthController < ApplicationController
  def login
    email = login_params[:email]
    password = login_params[:password]
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      render json: { token: encode_token({ user_id: user.id }) }
    end
  end

  def sign_up
    email = sign_up_params[:email]
    password = sign_up_params[:password]
    if User.find_by(email: email).nil?
      user = User.new(email: email, password: password, password_confirmation: password)
      if user.save
        render json: { token: encode_token({ user_id: user.id }) }, status: :created
      end
    end
    render json: { error: "Email already exists" }, status: :unprocessable_entity
  end

  # logout endpoint (not implemented) - delete this method when implementing JWT authentication in your application
  def logout
    # delete the user's token from the session
    # clear_session
    render json: { message: "Logged out successfully" }
  end

  private

  def login_params
    params.permit("email", "password")
  end

  def sign_up_params
    params.permit("email", "password", "password_confirmation")
  end
end
