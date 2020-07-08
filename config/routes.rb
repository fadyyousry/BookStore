Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  resources :books, :constraints => { :format => 'html' }
  resources :authors, only: [:new, :index]
  resources :categories, only: [:new, :index]
end
