# frozen_string_literal: true

module V1
  class Tickets < Grape::API
    resource :tickets do
      auth :jwt

      params do
        requires :subject, type: String
        requires :body, type: String
        requires :company_id, type: Integer
      end
      post do
        declared_params = declared(params)
        result = CreateTicket.call(**declared_params, profile: current_account.profile)
        error! result.message, status: 422 unless result.success?
      end

      params do
        requires :id, type: Integer
      end
      post ':id/cancel' do
        declared_params = declared(params)
        result = CancelTicket.call(**declared_params)
        error! result.message, status: 422 unless result.success?
      end

      params do
        requires :id, type: Integer
        requires :body, type: String
      end
      post ':id/reply' do
        declared_params = declared(params)
        result = ReplyToTicket.call(**declared_params, operator_id: current_account.profile.operator.id)
        error! result.message, status: 422 unless result.success?
      end
    end
  end
end
