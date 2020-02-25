class Trip < ApplicationRecord

  validates_presence_of :bike_id, :user_id, :started_at, :finished_at
  validates_presence_of :origin_station, :destination_station
  validates_presence_of :traveled_distance

  belongs_to :bike
  belongs_to :user
  belongs_to :station, foreign_key: 'origin_station'
  belongs_to :station, foreign_key: 'destination_station'
end
