Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "api/auth/login", to: "users#login"
  get "api/auth/auto_login", to: "users#auto_login"
end
