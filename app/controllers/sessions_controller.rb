class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:user_url]
    else
      flash.now[:alert] = 'You are not logged in'
      render :new
    end
  end

  def destroy
    session.clear
    cookies.delete(:user_url)
    redirect_to root_path
  end
end
