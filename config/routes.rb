# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  get '/books', to: redirect('/')

  devise_for :users
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
