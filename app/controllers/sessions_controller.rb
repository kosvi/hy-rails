class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to signin_path, notice: "User #{params[:username]} does not exist!"
    else
      session[:user_id] = user.id if !user.nil?
      redirect_to user, notice: "Welcome back!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
