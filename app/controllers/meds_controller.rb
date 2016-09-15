class MedsController < ApplicationController

  def index
    @messages = [ 'I heard you were feeling unwell. RemindMe is here for you!',
                  'I hate to see you feeling blue so here is my get well wish to you. Love RemindMe',
                  'You are gonna feel so much better in no time at all!'
                ]
    @meds = Med.where(user_id: current_user)
    @user = User.find_by_id(params[:user_id])
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
      redirect_to meds_path(current_user)
      flash[:success] = 'You have successfully tracked a medication'
    else
      redirect_to new_med_path
      flash[:error] = @med.errors.full_messages.join(", ")
    end
  end

  def delete
    @med = Med.find_by_id(params[:id])
    @med.destroy
    redirect_to meds_path(current_user)
  end

  private

  def med_params
    params.require(:med).permit(:med_name)
  end

end
