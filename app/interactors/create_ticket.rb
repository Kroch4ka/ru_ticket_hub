# frozen_string_literal: true

class CreateTicket
  include Interactor

  def call
    ticket = Ticket.new(subject: context.subject,
                        body: context.body,
                        company_id: context.company_id,
                        profile: context.profile)
    context.fail!(message: ticket.errors.full_messages) unless ticket.save
  end
end
