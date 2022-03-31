Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  get 'users/index'
  get 'users/show'
  resources :users, only: [:index, :show] 
  resources :books
  root 'books#index'
end
