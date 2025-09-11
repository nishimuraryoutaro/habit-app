class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @goal = @user.goals.order(:created_at).first || @user.goals.build
    @goals  = @user.goals.order(created_at: :desc)

    @target_preview =
      if @goal.target_date.blank? && @goal.start_date.present?
        @goal.start_date + 3.months
      end
  end


  def update
    @user = current_user
    @goal = @user.goals.order(:created_at).first || @user.goals.build
    if @goal.update(goal_params)
      redirect_to profile_path(@user), notice: "プロフィールを更新しました。"
    else
      @goal = @user.goals.order(:created_at).first || @user.goals.build
      render :show, alert: "プロフィールの更新に失敗しました。"
    end
  end

  def create_goal
    @user = current_user
    goal = @user.goals.new(goal_params)
    if goal.save
      redirect_to profile_path(@user), notice: "新しい目標を作成しました。"
    else
      redirect_to profile_path(@user), alert: goal.errors.full_messages.join(", ")
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :start_date, :target_date, :description)
  end
end
