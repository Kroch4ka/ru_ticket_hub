# frozen_string_literal: true

class FinalizeResetPassword
  include Interactor

  # TODO: Учитывать IP адрес клиента и ограничивать количество попыток сброса пароля
  def call
    return context.fail!(message: 'Invalid token') unless account
    return context.fail!(message: updated_account.errors.messages) unless updated_account.valid?

    updated_account.save!
  end

  def account = @account || Account.find_by(reset_password_token: context.reset_password_token)

  def updated_account
    account.tap do |acc|
      acc.password = context.password
      acc.password_confirmation = context.password_confirmation
      acc.reset_password_token = nil
      acc.reset_password_sent_at = nil
    end
  end
end
