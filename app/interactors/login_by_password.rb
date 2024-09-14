# frozen_string_literal: true

class LoginByPassword
  include Interactor

  def call
    email = context.email
    password = context.password
    account = Account.find_by(email:)
    account&.authenticate(password) ? build_token(account) : fail_login!
  end

  def build_token(account) = ActiveRecord::Base.transaction do
    result = BuildAccessToken.call(payload: { account_id: account.id })
    result.success? ? context.token = result.token : fail_login!
    AccessToken.create!(token: context.token, account_id: account.id)
  rescue StandardError
    fail_login!
  end

  def fail_login!
    context.fail!(message: 'email or password is not valid')
  end
end
