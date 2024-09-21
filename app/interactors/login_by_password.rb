# frozen_string_literal: true

class LoginByPassword
  include Interactor

  def call
    email = context.email
    password = context.password
    account = Account.find_by(email:)
    account&.authenticate(password) ? build_token(account) : fail_login!
  end

  def build_token(account)
    result = BuildAccessToken.call(payload: { account_id: account.id })
    fail_login! unless result.success?
    AccessToken.create!(token: result.token, account_id: account.id)
    context.token = result.token
  rescue StandardError => e
    Rails.logger.error(e.message)
    fail_login!
  end

  def fail_login!
    context.fail!(message: 'email or password is not valid')
  end
end
