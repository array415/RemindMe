class AlertsController < ApplicationController

  def new
    @alert = Alert.new
    if current_user == nil
      redirect_to '/'
    end
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
    params.require(:alert).permit(:alert_time)
  end
end
