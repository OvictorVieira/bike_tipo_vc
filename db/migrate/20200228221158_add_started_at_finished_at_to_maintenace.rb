class AddStartedAtFinishedAtToMaintenace < ActiveRecord::Migration[6.0]
  def change
    add_column :bike_maintenances, :started_at, :timestamp, null: false
    add_column :bike_maintenances, :finished_at, :timestamp
  end
end
