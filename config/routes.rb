Rails.application.routes.draw do
  resources :squads
  resources :seasons
  resources :team_members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#main'
end
