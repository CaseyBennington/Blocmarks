Rails.application.routes.draw do
  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:index, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  post :incoming, to: 'incoming#create'

  devise_for :users
  resources :users, only: [:show]

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
