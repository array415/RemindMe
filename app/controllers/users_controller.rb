class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect_to '/'
    end
  end

  def new
    @user = User.new
    if current_user
      redirect_to user_path(current_user)
      flash[:error] = 'You are already logged in'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_path(@user)
      flash[:success] = 'You have successfully signed up'
    end

  end

  def edit
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect_to '/'
    end

  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone_num, :password)
  end
end
