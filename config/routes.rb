Rails.application.routes.draw do
  get 'likes/index'

  resources :topics do
    resources :bookmarks, only: [:create, :new]
  end

  resources :bookmarks, only: [:index, :edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
  end

  post :incoming, to: 'incoming#create'

  devise_for :users
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
