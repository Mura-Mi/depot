class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
  end

  def create
    user = User.find_by_name(params[:name]);
    if user and user.authenticate(params[:password]) then
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert:"Invalid username or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "You've logged out."
  end
end
