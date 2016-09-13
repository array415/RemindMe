class MedsController < ApplicationController

  def index
    @meds = Med.where(user_id: current_user)
    @user = User.find_by_id(params[:id])
    if current_user != @user
      flash[:error] = 'You are not authorized to view this page'
      redirect_to user_path(current_user)
    end
    not_logged_in
  end

  def show
    @med = Med.find_by_id(params[:id])
    if current_user.id != @med.user_id
      flash[:error] = 'You are not authorized to view this page'
      redirect_to user_path(current_user)
    end
    not_logged_in

  end

  def new
    @med = Med.new
    not_logged_in
  end

  def create
    @med = Med.new(med_params)
    current_user.meds << @med
    if @med.save
      redirect_to user_path(current_user)
      flash[:success] = 'You have successfully created an alert'
    end
  end

  private

  def med_params
    params.require(:med).permit(:med_name)
  end

end
