class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @final_goal = current_user.goals.order(target_date: :desc).first
  end
end