Rails.application.routes.draw do
  resources :orders do
    collection do
      post :add_product
    end
  end
  resources :products
  root to: 'products#index'
  devise_for :users
  resources :users
end
