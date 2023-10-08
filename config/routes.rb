# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'books#index'
  get '/books', to: redirect('/')
  resources :books

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :users, only: %i[index show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
