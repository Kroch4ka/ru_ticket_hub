# frozen_string_literal: true

module V1
  class Profiles < Grape::API
    namespace :profiles do
      auth :jwt

      get 'current' do
        status 200
        current_account.profile
      end

      params do
        requires :name, type: String
        optional :phone_number, type: String
      end
      post 'activate' do
        declared_params = declared(params, include_missing: false)
        result = ActivateProfile.call(**declared_params, profile: current_account.profile)
        if result.success?
          status 200
        else
          error! result.message, 401
        end
      end
    end
  end
end
