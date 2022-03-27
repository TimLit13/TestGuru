class BadgesController < ApplicationController
  def index
    @badges = Badges.all
  end

  def show
    @badge = Badge.find(params[:id])
  end
end
