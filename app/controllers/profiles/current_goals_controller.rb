# app/controllers/profiles/current_goals_controller.rb
class Profiles::CurrentGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    goal = @user.goals.find(params[:goal_id])
    session[:current_goal_id] = goal.id
    redirect_to root_path(goal_id: goal.id), notice: "この目標をHOMEの表示対象にしました。"
  end

  private
  def set_user
    @user = User.find(params[:profile_id])
    redirect_to(root_path, alert: "権限がありません") unless @user == current_user
  end
end
