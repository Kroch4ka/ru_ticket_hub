class User < ApplicationRecord
  has_secure_password

  CUSTOMER_ROLE = 0
  OPERATOR_ROLE = 1
  VERIFIER_ROLE = 2
  ADMIN_ROLE = 3

  enum :role, { customer: CUSTOMER_ROLE, operator: OPERATOR_ROLE, verifier: VERIFIER_ROLE, admin: ADMIN_ROLE }

  has_many :tickets, -> { joins(:tickets).where("tickets.creator_id = ?", id) }
end
