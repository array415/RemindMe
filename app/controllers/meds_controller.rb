class MedsController < ApplicationController

  def new
    @med = Med.new
  end

  def create
    @med = Med.new(med_params)
    current_user.meds << @med
    if @med.save
      redirect_to '/'
    end
  end

  private

  def med_params
    params.require(:med).permit(:med_name)
  end
end
