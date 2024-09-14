# frozen_string_literal: true

class SignupByPassword
  include Interactor

  def call
    context.fail!(message: 'not_confirmed') unless password_confirmed?
    account.valid? ? create_account : context.fail!(message: account.errors.messages)
  end

  private

  def create_account = ActiveRecord::Base.transaction do
    account.save!
    result = BuildAccessToken.call(payload: { account_id: account.id })
    result.success? ? context.token = result.token : context.fail!(message: 'can not generate access token')
    AccessToken.create!(token: context.token, account_id: account.id)
  rescue StandardError => e
    Rails.logger.error("Error creating account: #{e.message}")
    context.fail!(message: 'can not generate access token')
  end

  def account = @account ||= Account.new(password: context.password,
                                         password_confirmation: context.password_confirmation,
                                         email: context.email)
end
