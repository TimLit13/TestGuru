class Admin::AchievementsController < Admin::BaseController
  def index
    @achievements = Achievement.order(user_id: :asc, created_at: desc)
  end
end