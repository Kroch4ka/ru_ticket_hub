# frozen_string_literal: true

module Events
  module Tickets
    class AfterTakeToWork
      def call(ticket, operator)
        ticket.update!(operator_id: operator.id)
      end
    end
  end
end
