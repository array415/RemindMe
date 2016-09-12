class AlertsController < ApplicationController

  def index
    @alerts = Alert.where(user_id: current_user)
    not_logged_in
  end

  def show
    @alert = Alert.find_by_id(params[:id])
    not_logged_in
  end

  def new
    @alert = Alert.new
    @meds = Med.find_by_user_id(current_user)
    not_logged_in
  end

  def create
    @alert = Alert.new(alert_params)
    current_user.alerts << @alert
    if @alert.save
      redirect_to '/'
    end
  end

  private

  def alert_params
    params.require(:alert).permit(:alert_time, :med_id)
  end

end
