class Signup
  include Interactor

  def call
    context.fail!(error: :not_confirmed) unless password_confirmed?
    if account.valid?
      account.save!
    else
      context.fail!(error: account.errors.messages)
    end
  end

  private

  def password_confirmed?
    context.password == context.password_confirmation
  end

  def account = @account ||= Account.new(password: context.password, email: context.email)
end
