Rails.application.routes.draw do
  api_guard_routes for: 'users'
end
