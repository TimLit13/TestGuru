class Admin::BaseController < ApplicationController

  layout 'admin'

  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: "You are not authorized to view #{request.path} page." unless current_user.admin?
  end   
end