class AddAlertTimeToAlert < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :alert_time, :time
  end
end
