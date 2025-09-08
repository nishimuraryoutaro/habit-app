class DailyTasksController < ApplicationController
  before_action :authenticate_user!
  def update
    @daily_task = current_user.daily_tasks.find(params[:id])
  end

  private
  def daily_task_params
    params.require(:daily_task).permit(:done, :title, :priority)
  end
end