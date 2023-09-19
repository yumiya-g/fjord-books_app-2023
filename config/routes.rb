# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: redirect("/#{I18n.default_locale}/books"), as: :redirected_root

  scope '/:locale' do
    resources :books, as: :localed_book
  end
end
