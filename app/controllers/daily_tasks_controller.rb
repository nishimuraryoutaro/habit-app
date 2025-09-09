class DailyTasksController < ApplicationController
  before_action :authenticate_user!
  def update
    task = current_user.daily_tasks.find(params[:id])
    if task.update(daily_task_params)
      redirect_to root_path(date: task.date), notice: "タスクを更新しました。"
    else
      redirect_to root_path(date: task.date), alert: "タスクの更新に失敗しました。"
    end
  end

  private
  def daily_task_params
    params.require(:daily_task).permit(:done, :title, :priority)
  end
end
