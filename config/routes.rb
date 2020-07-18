Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  resources :books, only: [:show, :index]
  resources :authors, only: [:show]
  resources :categories, only: [:show]
  resources :bills, only: [:new]

  namespace :manager do
    resources :books, except: [:show]
    resources :users
    resources :authors, only: [:index, :destroy]
    resources :categories, only: [:index, :destroy]
    root 'dashboard#index'
  end

end
