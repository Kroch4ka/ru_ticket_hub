# frozen_string_literal: true

module Operators
  module V1
    class Tickets < Grape::API
      resource :tickets do
        params do
          requires :id, type: Integer
        end
        post ':id/take' do
          declared_params = declared(params)
          result = TakeTicket.call(**declared_params, operator_id: current_account.profile.operator.id)
          error! result.message, status: 422 unless result.success?
        end
      end
    end
  end
end
