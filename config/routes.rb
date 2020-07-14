Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/hello', to: 'first#hello'
  get '/hi', to: 'first#hi'

  # get '/users', to: 'users#index'
  # get 'users/:id', to: 'users#show'
  # post 'users', to: 'users#create'
  # delete 'users/:id', to: 'users#destory'
  # patch 'users/:id', to: 'users#update'

  get '/me', to: 'users#me'
  delete '/sessions', to: 'sessions#destroy'
  resources :users
  resources :records
  resources :tags
  resources :taggings, except: [:update]
  resources :sessions, only: [:create]
end



