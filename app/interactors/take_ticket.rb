# frozen_string_literal: true

class TakeTicket
  include Interactor

  def call
    ticket = Ticket.find_by(id: context.id)
    context.fail!(message: 'Ticket not found') unless ticket
    context.fail!(message: 'Operator not found') unless Operator.exists?(id: context.operator_id)
    ticket.with_lock do
      ticket.update!(operator_id: context.operator_id)
      ticket.assign!
    end
  end
end
