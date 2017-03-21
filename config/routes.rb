Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  resource :search, only: [:show]
  resource :tracks, only: [:create, :destroy]
  get 'sign_in', to: 'pages#sign_in'
  get '/auth/spotify/callback', to: 'pages#spotify'
end
