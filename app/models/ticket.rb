class Ticket < ApplicationRecord
  include AASM

  belongs_to :operator, optional: true, class_name: "User", foreign_key: "operator_id"
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :company

  aasm requires_lock: true do
    state :pending, initial: true
    state :active
    state :review
    state :waiting_reply
    state :cancelled
    state :resolved

    event :take_to_work, after: ->(*args) { Events::Tickets::AfterTakeToWork.new.call(*args) } do
      transitions from: :pending, to: :active
    end

    event :reply do
      transitions from: :active, to: :waiting_reply, guard: ->(replier) { replier.operator? }
      transitions from: :waiting_reply, to: :active, guard: ->(replier) { replier.customer? }
      transitions from: :active, to: :active
      transitions from: :waiting_reply, to: :waiting_reply
    end

    event :cancel do
      transitions from: %i[pending active review waiting_reply], to: :cancelled
    end

    event :resolve do
      transitions from: %i[pending active review waiting_reply], to: :resolved
    end
  end
end
