class Trip < ApplicationRecord

  validates_presence_of :bike_id, :user_id, :started_at, :origin_station

  belongs_to :bike
  belongs_to :user

  def load_origin_station
    Station.find(origin_station)
  end

  def load_destination_station
    Station.find(destination_station)
  end
end
