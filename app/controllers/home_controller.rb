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
    @focused_goal = if params[:goal_id].present?
    current_user.goals.find_by(id: params[:goal_id])
    end
    @final_goal = @focused_goal || current_user.goals.order(:target_date, :created_at).first
  end
end
