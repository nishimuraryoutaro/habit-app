class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    raw = params[:date]

    if raw.empty?
       @selected_date = Date.current
    else
      if raw.match?(/\A\d{4}-\d{2}-\d{2}\z/)
        y, m, d = raw.split("-")
        if Date.valid_date?(y, m, d)
          @selected_date = Date.new(y, m, d)
        else
          @selected_date = Date.current
        end
      end
    end

    @final_goal = current_user.goals.order(target_date: :desc).first
  end
end