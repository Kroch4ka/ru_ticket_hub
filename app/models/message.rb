class Message < ApplicationRecord
  belongs_to :author, foreign_key: { to_table: :profiles }, index: true
  belongs_to :ticket
end
