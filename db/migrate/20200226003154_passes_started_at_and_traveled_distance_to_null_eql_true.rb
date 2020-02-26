class PassesStartedAtAndTraveledDistanceToNullEqlTrue < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :finished_at, :timestamp, null: true
    change_column :trips, :traveled_distance, :float, null: true
  end
end
