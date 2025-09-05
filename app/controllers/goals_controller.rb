class GoalsController < ApplicationController
  before_action :set_goal, only: [ :show, :edit, :update, :destroy ]


  def index
    @goals = Goal.all
  end

  def show
    @goal = current_user.goals.find(params[:id])
  end


  def new
    @goal = Goal.new
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end


  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to @goal, notice: "Goalを作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update(goal_params)
      redirect_to @goal, notice: "Goalを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    redirect_to goals_url, notice: "Goalを削除しました。"
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :description, :target_date, :progress)
    end
end
