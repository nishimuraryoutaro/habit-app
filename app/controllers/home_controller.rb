class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    return render "landing" unless user_signed_in?
    @selected_date = (Date.iso8601(params[:date]) rescue nil) || Date.current
    @goal = current_goal
    # 日付のパース処理
    # raw = params[:date].to_s.strip

    # if raw.empty?
    #    @selected_date = Date.current
    # else
    #   if raw.match?(/\A\d{4}-\d{2}-\d{2}\z/)
    #     y, m, d = raw.split("-").map(&:to_i)
    #       if Date.valid_date?(y, m, d)
    #         @selected_date = Date.new(y, m, d)
    #       else
    #         @selected_date = Date.current
    #       end
    #   else
    #     @selected_date = Date.current
    #   end
    # end
    # 目標の取得
   @todos_today =
      if @goal
        current_user.daily_tasks.where(goal: @goal, date: @selected_date)
                    .order(created_at: :asc).limit(3)
      else
        DailyTask.none
      end

    @done_count  = @todos_today.where(done: true).count
    @total_count = @todos_today.size

    month = @selected_date.beginning_of_month..@selected_date.end_of_month
    @days_with_todos = @goal ? current_user.daily_tasks.where(goal: @goal, date: month).group(:date).count : {}
    @streak = current_user.streak_count
  end
end