class CreateMeds < ActiveRecord::Migration[5.0]
  def change
    create_table :meds do |t|
      t.references :user, foreign_key: true
      t.string :med_name

      t.timestamps
    end
  end
end
