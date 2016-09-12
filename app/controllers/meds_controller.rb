class MedsController < ApplicationController

  def index
    @meds = Med.where(user_id: current_user)
  end

  def show
    @med = Med.find_by_id(params[:id])
  end

  def new
    @med = Med.new
    if current_user == nil
      redirect_to '/'
    end
  end

  def create
    @med = Med.new(med_params)
    current_user.meds << @med
    if @med.save
      redirect_to user_path(current_user)
    end
  end

  private

  def med_params
    params.require(:med).permit(:med_name)
  end
end
