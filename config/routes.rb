Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  get '/admin', to: 'dashboard#index'

  resources :books
  resources :authors, only: [:show, :index, :destroy]
  resources :categories, only: [:show, :index, :destroy]
end
