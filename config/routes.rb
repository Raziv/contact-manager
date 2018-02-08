Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :contacts
  resources :groups
  resources :texts

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/search', to: 'contacts#search'

  root 'sessions#new'
end
