Rails.application.routes.draw do
  root 'daily_players#index'
  get 'users/new'
  get 'signup' => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :season_players
  resources :pages
  resources :last_seven_players, only: [:index, :show]
  resources :daily_players do
      get 'find_points_leader'
      get 'find_assists_leader'
      get 'find_rebounds_leader'
      get 'find_steals_leader'
      get 'find_blocks_leader'
  end

end
