class SignupByPassword
  include Interactor

  def call
    context.fail!(message: "not_confirmed") unless password_confirmed?
    if account.valid?
      account.save!
    else
      context.fail!(message: account.errors.messages)
    end
  end

  private

  def password_confirmed?
    context.password == context.password_confirmation
  end

  def account = @account ||= Account.new(password: context.password, email: context.email)
end
