Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'tracks#show'
  resource :search, only: [:show]
  resource :tracks do
    resource :votes
  end
  get 'sign_in', to: 'pages#sign_in'
  get 'index', to: 'pages#index'
  get 'stats', to: 'stats#show'
  put 'play', to: 'tracks#play'
  get 'play', to: 'tracks#play'
  get 'spotify', to: 'pages#spotify'
  get '/auth/spotify/callback', to: 'application#spotify'
end
