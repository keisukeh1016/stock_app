Rails.application.routes.draw do
  get 'stocks/index'
  root 'stocks#index'
  resources :stocks
end
