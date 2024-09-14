# frozen_string_literal: true

class AccountMailer < ApplicationMailer
  def password_recovery_email
    @account = params[:account]
    mail(to: @account.email, subject: 'Сброс пароля')
  end
end
