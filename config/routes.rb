Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  get '/admin', to: 'dashboard#index'

  resources :books, only: [:show, :index]
  resources :authors, only: [:show]
  resources :categories, only: [:show]

  namespace :manager do
    resources :books
    resources :authors, only: [:index, :destroy]
    resources :categories, only: [:index, :destroy]
  end

end
