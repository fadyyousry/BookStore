Rails.application.routes.draw do
  get 'google_books/index'
  post 'google_books/add'

  resources :categories
  resources :books
  resources :publishers
  resources :authors


  root 'google_books#index'
end
