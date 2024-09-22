# frozen_string_literal: true

module V1
  class Companies < Grape::API
    resource :companies do
      auth :jwt

      get do
        Company.all
      end
    end
  end
end
