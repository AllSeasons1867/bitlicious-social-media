Rails.application.routes.draw do
  resources :story_comments
  resources :picture_comments
  resources :stories do
    resources :story_comments
  end
  resources :pictures do
    resources :picture_comments
  end
  # resources :comments

  resource :session, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :destroy]

  get '/', to: "home#index"
  get 'search', to: "home#search"
  root to: 'home#index'

  get('/about', {to: 'home#show'})

  resources :comments

  resources :video_comments

  resources :posts do
    resources :comments
  end
  # root to: 'videos#index'
  resources :videos do
    resources :video_comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :dashboard
  end
  
end

