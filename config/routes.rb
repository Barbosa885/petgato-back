Rails.application.routes.draw do
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#find'
  post '/users', to: 'users#create'
  delete '/users/:id', to: 'users#destroy'
  put '/users/:id', to: 'users#update'

  resources :users, params: :name
  post '/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
