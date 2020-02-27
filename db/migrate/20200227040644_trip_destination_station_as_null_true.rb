class TripDestinationStationAsNullTrue < ActiveRecord::Migration[6.0]
  def change
    change_column :trips, :destination_station, :bigint, null: true
  end
end
