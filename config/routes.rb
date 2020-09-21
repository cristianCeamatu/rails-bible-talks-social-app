Rails.application.routes.draw do
  root 'opinions#index'
  resources :opinions
  resources :users, only: %i[show new create]
  resources :sessions, only: %i[create destroy]
  resources :followings, only: %i[create destroy]
end
