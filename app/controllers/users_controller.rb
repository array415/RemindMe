class UsersController < ApplicationController

  def index
    @meds = Med.all
    @alerts = Alert.all
    @users = User.all
  end

  def show
    not_logged_in
    @user = User.find_by_id(params[:id])
    @alerts = Alert.where(user_id: current_user)
    @meds = Alert.where(user_id: current_user)
    if current_user != @user
      flash[:error] = 'You are not authorized to view this page'
      redirect_to user_path(current_user)
    end
  end

  def new
    @user = User.new
    if current_user
      flash[:error] = 'You are already logged in'
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:success] = 'You have successfully signed up'
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def edit
    not_logged_in
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect_to user_path(current_user)
      flash[:error] = 'You are not authorized to view this page'
    end
  end

  def update
    #TODO: check for authorization to destroy user.
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    end
  end

  def destroy
    #TODO: check for authorization to destroy user.
    @user = User.find_by_id(params[:id])
    @user.meds.destroy_all
    @user.alerts.destroy_all
    @user.destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone_num, :password)
  end
end
