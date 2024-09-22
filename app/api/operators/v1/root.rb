# frozen_string_literal: true

module Operators
  module V1
    class Root < Grape::API
      version 'v1', using: :path

      auth :jwt

      mount Tickets
    end
  end
end
