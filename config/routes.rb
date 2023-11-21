Rails.application.routes.draw do
  resources :reports
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :users, only: %i(index show)

  resources :books do
    resources :comment, only: [:create, :edit, :destroy]
  end
  
  resources :reports do
    resources :comment, only: [:create, :edit, :destroy]
  end
end
