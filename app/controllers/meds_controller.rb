class MedsController < ApplicationController

  def index
    # TODO: If you want to expand this to more content, consider putting it in an
    # external file that you can update easily without blowing up your controller
    @messages = [ 'I heard you were feeling unwell. RemindMe is here for you!',
                  'I hate to see you feeling blue so here is my get well wish to you. Love RemindMe',
                  'You are gonna feel so much better in no time at all!'
                ]

    @user = User.find_by_id(params[:user_id])
    @meds = Med.where(user_id: current_user)
    # TODO: play with the placement of not_logged_in
    if not_logged_in
    elsif current_user != @user
      flash[:error] = 'You are not authorized to view this page'
      redirect_to user_path(@user)
    end
  end

  def new
    not_logged_in
    @med = Med.new
  end

  def create
    @med = Med.new(med_params)
    current_user.meds << @med
    if @med.save
      flash[:success] = 'You have successfully tracked a medication'
      redirect_to meds_path(current_user)
    else
      flash[:error] = @med.errors.full_messages.join(", ")
      redirect_to new_med_path
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
