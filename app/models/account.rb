# frozen_string_literal: true

class Account < ApplicationRecord
  has_secure_password

  validates :email, email: true, uniqueness: true
  validates :password,
            presence: true,
            length: { minimum: 6 },
            if: ->(record) { record.new_record? || record.password.present? || record.password_confirmation.present?  }

  has_one :profile
end
