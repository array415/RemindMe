class AlertsController < ApplicationController

  def new
    @alert = Alert.new
    @meds = Med.find_by_user_id(current_user)
    if current_user == nil
      redirect_to '/'
    end
  end

  def create
    # TODO: Include med_id somewhere magically
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
