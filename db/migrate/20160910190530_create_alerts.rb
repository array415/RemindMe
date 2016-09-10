class CreateAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :alerts do |t|
      t.references :user, foreign_key: true
      t.references :med, foreign_key: true
      t.datetime :alert_time

      t.timestamps
    end
  end
end
