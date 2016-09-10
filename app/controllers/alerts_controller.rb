class AlertsController < ApplicationController

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(alert_params)
    if @alert.save
      redirect_to '/'
    end

  end

  private

  def alert_params
    alert_params.require(:alert).permit(:time)
  end
end
