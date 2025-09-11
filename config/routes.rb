# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :goals do
    resource :day_tasks, only: [ :edit, :create ], controller: "day_tasks"
  end

  resources :daily_tasks, only: [ :update ]

  resources :profiles,    only: [ :show, :update ]  do
     resources :goals, only: [ :create ], controller: "profiles/goals"
     resource  :current_goal, only: [ :create ], controller: "profiles/current_goals"
  end
end
