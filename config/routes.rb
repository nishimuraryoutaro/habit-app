# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :goals do
    resource :day_tasks, only: [ :edit, :create ], controller: "day_tasks"
  end

  resources :daily_tasks, only: [ :update ]     # チェック切替用（Homeから）
  resources :profiles,    only: [ :show, :update ]  # プロフィールで開始日・目的日を編集
end
