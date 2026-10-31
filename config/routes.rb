Rails.application.routes.draw do
  root "users#index"
  resources :users
  resource :session
end
