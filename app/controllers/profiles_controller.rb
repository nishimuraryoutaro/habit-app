class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @goal = @user.goals.order(:created_at).first || @user.goals.build
  end

  def update
    @user = User.find(params[:id])
    if @user.update(gaol_params)
      redirect_to profile_path(@user), notice: "プロフィールを更新しました。"
    else
      @goal = @user.goals.order(:created_at).first || @user.goals.build
      render :show, alert: "プロフィールの更新に失敗しました。"
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :start_date, :target_date, :description)
  end
end
