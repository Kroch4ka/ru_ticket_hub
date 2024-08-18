Rails.application.routes.draw do
  post "auth/login", to: "auth#login"
  post "auth/sign_up", to: "auth#sign_up"
  post "auth/logout", to: "auth#logout"
end
