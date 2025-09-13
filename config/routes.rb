# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :goals, only: [ :index, :show, :edit, :new, :update, :destroy ]
  resource :day_tasks, only: [ :edit, :create ]


  resources :daily_tasks, only: [ :update ]

  resources :profiles,    only: [ :show, :update ]  do
     resources :goals, only: [ :create ], controller: "profiles/goals"
  end
end
