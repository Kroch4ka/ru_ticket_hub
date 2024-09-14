# frozen_string_literal: true

module Profileable
  extend ActiveSupport::Concern

  included do
    has_one :profile, as: :profileable, touch: true
  end
end
