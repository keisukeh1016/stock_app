Rails.application.routes.draw do
  root 'users#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :stocks,     only: [:index, :show]
  resources :portfolios, only: [:create, :destroy]
end
