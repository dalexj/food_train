Rails.application.routes.draw do

  root 'pages#home'
  get '/dashboard', to: 'pages#dashboard'

  resources :groups, only: [:show, :index, :new, :create, :destroy] do
    resources :trains, only: [:create, :new]
  end
  post '/groups/:id/join', to: 'groups#join'
  post '/groups/:id/leave', to: 'groups#leave'

  resources :sessions, only: [:create]
  get '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'

  post '/train_options/:id/vote', to: 'votes#create'
  resources :trains, only: [] do
    resources :train_options, only: [:new, :create]
  end
end
