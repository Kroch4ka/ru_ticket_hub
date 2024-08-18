# frozen_string_literal: true

require "rails_helper"

RSpec.describe AuthController do
  describe "login" do
    let!(:user) { create(:user, email: "example@mail.ru", password: "1234") }

    it "возвращает токен" do
      post :login, params: { email: "example@mail.ru", password: "1234" }
      expect(response.body).to eq({ token: JWT.encode({ user_id: user.id }, ENV["HMAC_JWT_SECRET"]) }.to_json)
    end
  end

  describe "sign_up" do
    let(:params) { { password: "1234", password_confirmation: "1234", email: "example@mail.ru" } }

    it "создаёт пользователя" do
      expect { post :sign_up, params: params }.to change(User, :count).by(1)
      expect(JSON.parse(response.body).keys).to contain_exactly("token")
    end
  end
end
