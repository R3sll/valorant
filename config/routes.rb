Rails.application.routes.draw do
  get 'players/index'
  get 'teams/index'
  root "valorant#index"

  resources :valorant

  resources :agents
  resources :teams do
    resources :players
  end

end

Rails.application.routes.draw do
  get 'players/index'
  get 'teams/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end


Rails.application.routes.draw do
  # Other routes

  # For catching non-valid paths
  match '*path', to: 'errors#not_found', via: :all
end
