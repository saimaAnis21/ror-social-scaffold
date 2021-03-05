Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :friendships, only: [:new, :update, :destroy, :create]
  
  get 'friendships/(:id)', to: 'friendships#update'
  delete 'friendships/(:id)', to: 'friendships#destroy'
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
