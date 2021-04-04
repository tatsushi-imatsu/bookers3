Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  get "home/about" => "homes#about"
  resources :users, only: [:show,:index,:edit,:update, :create]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  
 end
end