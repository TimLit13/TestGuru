class SessionsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:user_requested_url] || root_path
    else
      flash.now[:alert] = 'You are not logged in'
      render :new
    end
  end

  def destroy
    session.clear
    cookies.delete(:user_requested_url)
    redirect_to root_path
  end
end
