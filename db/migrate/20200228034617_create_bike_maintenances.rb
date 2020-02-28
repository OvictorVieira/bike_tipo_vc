class CreateBikeMaintenances < ActiveRecord::Migration[6.0]
  def change
    create_table :bike_maintenances do |t|
      t.string :reason, null: false

      t.references :bike, foreign_key: true, null: false

      t.timestamps
    end
  end
end
