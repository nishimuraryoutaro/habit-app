class HomeController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    return unless user_signed_in?

    @final_goal = current_user.goals.order(target_date: :desc).first
  end
end