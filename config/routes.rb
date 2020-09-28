Rails.application.routes.draw do
  root 'opinions#index'
  resources :opinions, except: %i[edit destroy show]
  resources :users, only: %i[show create edit update]
  resources :sessions, only: %i[new create destroy]
  resources :followings, only: %i[create destroy]

  get 'sign_up', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sessions', to: 'sessions#new'
  get '/users', to: 'users#new'
end
