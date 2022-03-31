class Admin::AchievementsController < Admin::BaseController
  def index
    @achievements = Achievement.order(user_id: :asc, created_at: :desc)
  end

  def destroy
    @achievement = Achievement.find(params[:id])

    if @achievement.destroy
      redirect_to admin_achievements_path, notice: 'Achievement was successfully deleted.'
    else
      flash.now[:error] = "Could not delete Achievement"
      render :index
    end
  end
end