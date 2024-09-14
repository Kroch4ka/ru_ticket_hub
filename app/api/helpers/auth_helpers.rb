# frozen_string_literal: true

module Helpers
  module AuthHelpers
    def current_account = @account = Account.find(request_jwt.payload.account_id)
    def client_ip = env['action_dispatch.remote_ip'].to_s
  end
end
