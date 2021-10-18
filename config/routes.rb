Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "api/auth/login", to: "users#login"
  get "api/auth/auto_login", to: "users#auto_login"
  post "api/user/validate", to: "users#validate"
  post "api/user/create", to: "users#create"
  get "api/user", to: "users#index"
  post "api/user/details", to:"users#details"
  patch  "api/user/remove", to:"users#update"
  # post
  get "api/post", to: "posts#index"
  post "api/post/create", to: "posts#create"
  get "api/post/details", to: "posts#details"
  # test
  post "/test" , to: "users#testinsert"
  patch "/test/update", to: "users#testupdate"
end
