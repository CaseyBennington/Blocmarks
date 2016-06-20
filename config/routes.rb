Rails.application.routes.draw do
  resources :topics do
    resources :bookmarks, except: [:index]
  end

  post :incoming, to: 'incoming#create'

  devise_for :users
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
