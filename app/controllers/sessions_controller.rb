class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.confirm(user_params)
    if @user
      login(@user)
      redirect_to user_path(@current_user)
      flash[:success] = 'You have successfully logged in'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
    flash[:success] = 'You have successfully logged out'
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
