Rails.application.routes.draw do
  root 'opinions#index'
  resources :opinions
  resources :users, only: %i[show create]
  resources :sessions, only: %i[new create destroy]
  resources :followings, only: %i[create destroy]

  get 'sign_up', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get '*path' => redirect('/sign_in')
end
