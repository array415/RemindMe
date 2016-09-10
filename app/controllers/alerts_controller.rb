class AlertsController < ApplicationController

  def new
    @alert = Alert.new
  end

  def create
    @med = Med.find(1)
    @alert = Alert.new(alert_params)
    current_user.alerts << @alert
    @med.alerts << @alert
    if @alert.save
      redirect_to '/'
    end
  end

  private

  def alert_params
    params.require(:alert).permit(:alert_time)
  end
end
