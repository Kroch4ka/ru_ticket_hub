# frozen_string_literal: true

module Operators
  class Root < Grape::API
    mount V1::Root, to: 'operators'
  end
end
