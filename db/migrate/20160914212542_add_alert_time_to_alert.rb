class AddAlertTimeToAlert < ActiveRecord::Migration[5.0]
  def change
    add_column :alerts, :alert_time, :datetime
  end
end
