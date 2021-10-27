Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "api/auth/login", to: "users#login"
  get "api/auth/auto_login", to: "users#auto_login"
  post "api/user/validate", to: "users#validate"
  post "api/user/create", to: "users#create"
  get "api/user", to: "users#index"
  get "api/user/details", to:"users#details"
  patch  "api/user/remove", to:"users#remove"
  patch  "api/user/edit", to:"users#editUser"
  post "api/user/changePassword", to:"users#changePassword"

  post "api/user/resetPassword", to:"users#resetPassword"

  # post
  get "api/post", to: "posts#index"
  post "api/post/details", to: "posts#details"
  post "api/post/validateCreate", to: "posts#validateCreate"
  post "api/post/validateEdit", to: "posts#validateEdit"
  patch "api/post/update", to: "posts#update"
  post "api/post/create", to: "posts#create"
  patch  "api/post/remove", to:"posts#remove"
  post "api/post/csv", to:"posts#testCSV"
  post "api/post/upload", to:"posts#upload"
  get "api/post/download", to:"posts#download"
  # test
  post "/test" , to: "users#testinsert"
  patch "/test/update", to: "users#testupdate"
end
