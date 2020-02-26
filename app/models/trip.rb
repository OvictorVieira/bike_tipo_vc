class Trip < ApplicationRecord

  validates_presence_of :bike_id, :user_id, :started_at
  validates_presence_of :origin_station, :destination_station

  belongs_to :bike
  belongs_to :user
  belongs_to :station, foreign_key: 'origin_station'
  belongs_to :station, foreign_key: 'destination_station'
end
