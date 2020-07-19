Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  resources :books, only: [:show, :index]
  resources :authors, only: [:show]
  resources :categories, only: [:show]
  get '/bills/new', to: 'bills#new', as: :new_bill
  get '/cart', to: 'shopping#show_cart'
  get '/add_to_cart/:book_id', to: 'shopping#add_to_cart', as: :add_to_cart

  namespace :manager do
    resources :books, except: [:show]
    resources :users
    resources :authors, only: [:index, :destroy]
    resources :categories, only: [:index, :destroy]
    root 'dashboard#index'
  end

  mount StripeEvent::Engine, at: '/stripe_webhooks'
end
