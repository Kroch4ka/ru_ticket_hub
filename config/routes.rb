# frozen_string_literal: true

Rails.application.routes.draw do
  mount Accounts => '/'
  mount Profiles => '/'
end
