Rails.application.routes.draw do
  devise_for :users
  root 'statuses#index'
  resources :statuses
  



 
  

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
