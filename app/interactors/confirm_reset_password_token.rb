# frozen_string_literal: true

class ConfirmResetPasswordToken
  include Interactor

  RECOVERY_TOKEN_LIFETIME = 15.minutes

  def call
    account = Account.find_by(reset_password_token: context.reset_password_token)
    return if account && (DateTime.now.to_i - account.reset_password_sent_at.to_i) <= RECOVERY_TOKEN_LIFETIME

    context.fail!(message: 'Invalid token')
  end
end
