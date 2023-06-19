Rails.application.routes.draw do
  root "static_pages#home"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post "/product/:product_id/add_cart", to: "cart_items#add_cart", as: "add_cart"
  post "/cart_item/:cart_item_id/update_quantity", to: "cart_items#update_quantity", as: "update_quantity"
  resources :users, only: [:show, :edit, :update, :destroy] do
  end
  resource :cart, only: [:show] do
    resources :cart_items, only: [:destroy]
  end
  resources :products
  resources :orders do
    member do
      get :purchase_completed
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
