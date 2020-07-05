Rails.application.routes.draw do
  resources :categories
  resources :books
  resources :publishers
  resources :authors

  root 'books#index'
end
