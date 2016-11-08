Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :bookmarks, only: [:index]
  end

  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:index, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  post :incoming, to: 'incoming#create'

  get 'about' => 'welcome#about'
  root 'welcome#index'
end
