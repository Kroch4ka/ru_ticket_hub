# frozen_string_literal: true

class ActivateProfile
  include Interactor

  def call
    context.fail!(message: 'Profile is not set') unless context.profile
    context.fail!(message: 'Profile is already active') if context.profile.active

    context.profile.update!(active: true, name: context.name, phone_number: context.phone_number)
  end
end
