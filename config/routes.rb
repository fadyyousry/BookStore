Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  get '/admin', to: 'dashboard#index'

  resources :books, :constraints => { :format => 'html' }
  resources :authors, only: [:show, :index, :destroy], :constraints => { :format => 'html' }
  resources :categories, only: [:show, :index, :destroy], :constraints => { :format => 'html' }
end
