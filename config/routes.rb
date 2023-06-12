Rails.application.routes.draw do
  root "static_pages#home"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post "/confirmed_order", to: "carts#confirmed_order"
  post "/product/:product_id/add_cart", to: "cart_items#add_cart", as: "add_cart"
  resources :users, only: [:show, :edit, :update, :destroy] do
    resource :cart, only: [:show] do
      resources :cart_items, only: [:destroy]
    end
  end
  resources :products
  resources :orders do
    member do
      get :purchase_completed
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
