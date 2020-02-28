class CreateTripCommand

  def initialize(trip_repository)
    @trip_repository = trip_repository
  end

  def create!(bike_id, user_id, origin_station)
    @trip_repository.create!(bike_id: bike_id,
                             user_id: user_id,
                             origin_station: origin_station,
                             started_at: Time.now)
  end
end