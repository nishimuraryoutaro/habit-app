# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :goals do
    member do
      # カレンダーから開く「1日TODO編集フォーム（HTML/Frameで表示）」
      get  :day_editor
      # フォームで保存（1日の3件をまとめて更新）
      post :save_day
      # 「いいね（今日を達成）」= 選択日の3件を完了にしてCheckinを作成
      post :complete_day
    end
  end

  resources :daily_tasks, only: [ :update ]     # チェック切替用（Homeから）
  resources :profiles,    only: [ :show, :update ]  # プロフィールで開始日・目的日を編集
end
