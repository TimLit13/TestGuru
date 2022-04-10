class AchievementsController < ApplicationController
  def index
    @achievements = current_user.badges
  end
end
