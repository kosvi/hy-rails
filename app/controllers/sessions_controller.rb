class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user&.closed
      redirect_to signin_path, notice: "Your account is closed, please contact with admin"
    elsif user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to signin_path, notice: "Username or password incorrect!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
