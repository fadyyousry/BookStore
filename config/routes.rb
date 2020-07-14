Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  get '/admin', to: 'dashboard#index'

  resources :books, only: [:show, :index]
  resources :authors, only: [:show, :index, :destroy]
  resources :categories, only: [:show, :index, :destroy]

  namespace :manager do
    resources :books
  end

end
