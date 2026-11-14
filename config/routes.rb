Rails.application.routes.draw do
  root "reports#index"
  resources :users
  resources :reports
  resource :session
end
