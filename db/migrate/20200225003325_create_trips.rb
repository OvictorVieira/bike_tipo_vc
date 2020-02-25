class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.timestamp :started_at, null: false
      t.timestamp :finished_at, null: false
      t.float :traveled_distance, null: false
      t.bigint :origin_station, null: false
      t.bigint :destination_station, null: false

      t.references :bike, :user, foreign_key: true, null: false

      t.timestamps
    end

    add_foreign_key :trips, :stations, column: :origin_station
    add_foreign_key :trips, :stations, column: :destination_station
  end
end
