class UsersController < ApplicationController

  def index
    @meds = Med.all
    @alerts = Alert.all
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect_to redirect_to user_path(current_user)
      flash[:error] = 'You are not authorized to view this page'
    end
    not_logged_in
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
    else
      redirect_to new_user_path
      flash[:error] = @user.errors.full_messages.join(", ")
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
      flash[:error] = 'You are not authorized to view this page'
    end
    not_logged_in
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.meds.destroy_all
    @user.alerts.destroy_all
    @user.destroy
    redirect_to '/'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone_num, :password)
  end
end
