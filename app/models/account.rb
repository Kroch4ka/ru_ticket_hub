# frozen_string_literal: true

class Account < ApplicationRecord
  has_secure_password

  validates :email, email: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  has_one :profile
end
