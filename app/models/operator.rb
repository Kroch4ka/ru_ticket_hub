class Operator < ApplicationRecord
  include Profileable

  enum :role, { owner: 0 }
end
