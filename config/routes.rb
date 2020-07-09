Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  resources :books, :constraints => { :format => 'html' }
  resources :authors, only: [:index], :constraints => { :format => 'html' }
  resources :categories, only: [:index], :constraints => { :format => 'html' }
end
