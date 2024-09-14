# frozen_string_literal: true

class SendResetPasswordToken
  include Interactor

  def call
    if (account = Account.exists?(email: context.email))
      token = SecureRandom.random_number(100_000..999_999).to_s
      account.with_lock do
        account.update!(reset_password_token: token)
        AccountMailer.with(account:).password_recovery_email.deliver_now
        account.update!(reset_password_sent_at: Time.current)
      end
    else
      context.fail!(message: 'Account not found')
    end
  end
end
