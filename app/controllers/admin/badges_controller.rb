class Admin::BadgesController < Admin::BaseController
  
  before_action :set_badges, only: :index
  before_action :set_badge, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = Badge.new(badges_params)

    if @badge.save
      redirect_to admin_badge_path(@badge), notice: 'Badge was successfully created.'
    else
      flash.now[:error] = "Could not create Badge"
      render :new
    end
  end 

  def edit
  end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badge_path(@badge), notice: 'Badge was successfully updated.'
    else
      flash.now[:error] = "Could not update Badge"
      render :edit
    end
  end

  def destroy
    if @badge.destroy
      redirect_to admin_badges_path, notice: 'Badge was successfully deleted.'
    else
      flash.now[:error] = "Could not delete Badge"
      render :edit
    end
  end

  private

  def set_badge
    @badge = Badge.find(params[:id])
  end

  def set_badges
    @badges = Badge.all
  end

  def badges_params
    params.require(:badge).permit(:title, :image_url, :rule)
  end
end
