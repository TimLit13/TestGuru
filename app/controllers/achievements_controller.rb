class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.where(user_id: current_user.id).order(created_at: :desc)
  end
end
