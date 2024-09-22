# frozen_string_literal: true

class Root < Grape::API
  mount V1::Root
end
