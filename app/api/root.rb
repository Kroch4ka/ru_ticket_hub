# frozen_string_literal: true

class Root < Grape::API
  format :json

  use ActionDispatch::RemoteIp
  include Grape::Jwt::Authentication
  helpers ::Helpers::AuthHelpers

  mount V1::Root
  mount Operators::Root
end
