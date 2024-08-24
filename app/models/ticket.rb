class Ticket < ApplicationRecord
  include AASM

  belongs_to :user
  has_many :messages

  aasm do
    state :draft, initial: true
    state :pending
    state :in_work
    state :waiting_client
    state :closed
    state :cancelled

    event :submit do
      transitions from: :draft, to: :pending
    end

    event :take_to_work do
      transitions from: :pending, to: :in_work
    end

    event :reply_to_client do
      transitions from: :in_work, to: :waiting_client
    end

    event :reply_to_operator do
      transitions from: :waiting_client, to: :in_work
    end

    event :close do
      transitions from: [:in_work, :waiting_client], to: :closed
    end

    event :cancel do
      transitions from: [:draft, :pending, :in_work, :waiting_client], to: :cancelled
    end
  end
end
