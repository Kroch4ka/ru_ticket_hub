# frozen_string_literal: true

class Tickets < Grape::API
  format :json

  include Grape::Jwt::Authentication

  helpers ::Helpers::AuthHelpers

  auth :jwt

  resource :tickets do
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
    post ":id/take" do
      declared_params = declared(params)
      result = AssignTicket.call(**declared_params, operator_id: current_account.profile.operator.id)
      error! result.message, status: 422 unless result.success?
    end

    params do
      requires :id, type: Integer
      requires :operator_id, type: Integer
    end
    post ":id/assign" do
      declared_params = declared(params)
      result = AssignTicket.call(**declared_params)
      error! result.message, status: 422 unless result.success?
    end

    params do
      requires :id, type: Integer
    end
    post ":id/cancel" do
      declared_params = declared(params)
      result = CancelTicket.call(**declared_params)
      error! result.message, status: 422 unless result.success?
    end
  end
end
