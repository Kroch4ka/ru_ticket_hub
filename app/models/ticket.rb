# frozen_string_literal: true

class Ticket < ApplicationRecord
  include AASM

  belongs_to :operator, optional: true
  belongs_to :customer
  belongs_to :company
  has_many :messages

  aasm column: :status do
    state :new, initial: true
    state :assigned
    state :replied
    state :resolved
    state :cancelled

    event :assign do
      transitions from: :new, to: :assigned, guard: -> { operator.present? }
    end

    event :reply do
      transitions from: :assigned, to: :replied
    end

    event :resolve do
      transitions from: %i[assigned replied], to: :resolved
    end

    event :cancel do
      transitions from: :new, to: :cancelled, guard: -> { operator.blank? }
    end
  end
end
