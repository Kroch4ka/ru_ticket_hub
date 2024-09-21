# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :author, foreign_key: { to_table: :profiles }, inverse_of: :messages
  belongs_to :ticket
end
