class Profile < ApplicationRecord
  belongs_to :account
  delegated_type :profileable, types: %w[Operator Customer], dependent: :destroy
end
