class FinishTripCommand

  def initialize(trip, trip_repository, destination_station)
    @trip = trip
    @trip_repository = trip_repository
    @destination_station = destination_station
  end

  def finish!(traveled_distance)
    set_traveled_distance(traveled_distance)

    set_destination_station

    set_finished_at
  end

  private

  def set_traveled_distance(traveled_distance)
    @trip_repository.update(traveled_distance: traveled_distance)
  end

  def set_destination_station
    @trip_repository.update(destination_station: @destination_station.id)
  end

  def set_finished_at
    @trip_repository.update(finished_at: Time.now)
  end
end