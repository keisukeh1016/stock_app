Rails.application.routes.draw do
  root 'stocks#index'
  resources :stocks
  resources :users
end
