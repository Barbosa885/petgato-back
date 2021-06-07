Rails.application.routes.draw do
  resources :tags
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  post '/users', to: 'users#create'
  delete '/users/:id', to: 'users#destroy'
  put '/users/:id', to: 'users#update'

  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show'
  post '/posts', to: 'posts#create'
  delete '/posts/:id', to: 'posts#destroy'
  put '/posts/:id', to: 'posts#update'

  resources :users, params: :name
  post '/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end