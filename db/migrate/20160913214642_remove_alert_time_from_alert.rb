class RemoveAlertTimeFromAlert < ActiveRecord::Migration[5.0]
  def change
    remove_column :alerts, :alert_time, :datetime
  end
end
