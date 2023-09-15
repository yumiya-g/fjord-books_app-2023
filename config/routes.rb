# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # rootにアクセスした際、URLにロケールを含めてリダイレクト（Localeの初期値は「ja」）
  root to: redirect("/#{I18n.default_locale}/books"), as: :redirected_root

  # URLのプレフィックスにロケールを含め、パスの別名「localed_book」を定義
  scope '/:locale' do
    resources :books, as: :localed_book
  end
end
