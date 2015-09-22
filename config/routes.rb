Rails.application.routes.draw do
  devise_for :users
  root 'statuses#index'
  resources :statuses
end
