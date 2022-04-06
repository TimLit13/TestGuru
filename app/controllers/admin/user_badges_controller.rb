class Admin::UserBadgesController < Admin::BaseController
  def index
    @user_badges = UserBadge.order(user_id: :asc, created_at: :desc)
  end

  def destroy
    @user_badge = UserBadge.find(params[:id])

    if @user_badge.destroy
      redirect_to admin_achievements_path, notice: 'Achievement was successfully deleted.'
    else
      flash.now[:error] = "Could not delete Achievement"
      render :index
    end
  end
end