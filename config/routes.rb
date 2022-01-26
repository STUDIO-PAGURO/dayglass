Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users
  resources :posts
  resources :users, only:  :show
end
