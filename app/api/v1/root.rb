# frozen_string_literal: true

module V1
  class Root < Grape::API
    version 'v1', using: :path

    mount Accounts
    mount Profiles
    mount Companies
    mount Tickets
  end
end
