class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    # 日付のパース処理
    raw = params[:date].to_s.strip

    if raw.empty?
       @selected_date = Date.current
    else
      if raw.match?(/\A\d{4}-\d{2}-\d{2}\z/)
        y, m, d = raw.split("-").map(&:to_i)
          if Date.valid_date?(y, m, d)
            @selected_date = Date.new(y, m, d)
          else
            @selected_date = Date.current
          end
      else
        @selected_date = Date.current
      end
    end
    # 目標の取得
    if params["goal_id"].present?
      @goal = current_user.goals.find_by(id: params["goal_id"])
      if @goal.nil?
          @goal = current_user.goals.order(:created_at).first
      end
    else
      @goal = current_user.goals.order(:created_at).first
    end
  end

  if @goal.present?
    @todos_today = current_user.daily_tasks.where(date: @selected_date).order(position: :desc, created_at: :asc).limit(3)
  else
    @todos_today = DailyTask.none
  end

  @done_count  = @todos_today.where(done: true).count
  @total_count = @todos_today.size

  if @goal.present?
    @days_with_todos =
      current_user.daily_tasks.where(goal: @goal).group(:date).count
  else
    @days_with_todos = {}
  end

end
