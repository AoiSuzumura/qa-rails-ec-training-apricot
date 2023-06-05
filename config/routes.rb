Rails.application.routes.draw do
  root "static_pages#home"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :products
  resources :orders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
