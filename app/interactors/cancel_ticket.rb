# frozen_string_literal: true

class CancelTicket
  include Interactor

  def call
    ticket = Ticket.find_by(id: context.id)
    context.fail!(message: 'Ticket not found') unless ticket
    ticket.cancel!
  end
end
