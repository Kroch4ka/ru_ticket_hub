# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  def create?
    user.present? && user.verifier?
  end

  def destroy?
    user.present? && user.verifier?
  end
end
