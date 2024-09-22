# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Accounts do
  describe 'POST /api/v1/accounts/sign_up' do
    let(:valid_attributes) do
      {
        email: 'test@example.com',
        password: 'test123',
        password_confirmation: 'test123'
      }
    end

    it 'creates a new account with valid parameters' do
      post '/api/v1/accounts/sign_up', params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(Account.count).to eq(1)
    end

    it 'creates a new non active customer' do
      post '/api/v1/accounts/sign_up', params: valid_attributes
      expect(Customer.count).to eq(1)
      expect(Profile.all.first.active).to be_falsey
    end
  end

  describe 'POST /accounts/log_in' do
    let(:account) { create(:account) }
    let(:valid_attributes) { { email: account.email, password: account.password } }

    it 'logs in an existing account with valid parameters' do
      post '/api/v1/accounts/log_in', params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(response.body.as_json).to include('token')
    end
  end

  describe 'POST /api/v1/accounts/reset_password/request' do
    let(:account) { create(:account) }
    let(:valid_attributes) { { email: account.email } }

    it 'resets the password of an existing account with valid parameters' do
      post '/api/v1/accounts/reset_password/request', params: valid_attributes
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/accounts/reset_password/verify' do
    let(:account) do
      create(:account, reset_password_token: '123456', reset_password_sent_at: DateTime.now)
    end
    let(:valid_attributes) { { reset_password_token: account.reset_password_token } }

    it 'resets the password of an existing account with valid parameters' do
      post '/api/v1/accounts/reset_password/verify', params: valid_attributes
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/accounts/reset_password/finalize' do
    let(:account) do
      create(:account, reset_password_token: '123456', reset_password_sent_at: DateTime.now)
    end
    let(:valid_attributes) do
      {
        reset_password_token: account.reset_password_token,
        password: '1234567',
        password_confirmation: '1234567'
      }
    end

    it 'resets the password of an existing account with valid parameters' do
      post '/api/v1/accounts/reset_password/finalize', params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(account.reload.authenticate('1234567')).not_to be_falsey
    end
  end
end
