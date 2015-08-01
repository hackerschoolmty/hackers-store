Rails.application.routes.draw do
  resources :orders do
    collection do
      post :add_product
      post :remove_product
      get :pay
      post :process_payment
    end

  end
  get '/cart', to: 'orders#show', id: 'current'
  resources :products
  root to: 'products#index'
  devise_for :users
  resources :users
end
