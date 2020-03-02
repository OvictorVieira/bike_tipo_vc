class FinishTripCommand

  def initialize(trip, trip_repository, trip_subscriber, destination_station)
    @trip = trip
    @trip_repository = trip_repository
    @trip_subscriber = trip_subscriber
    @destination_station = destination_station
  end

  def finish!(traveled_distance)
    set_traveled_distance(traveled_distance)

    set_destination_station

    set_finished_at

    notify_subscribers
  end

  private

  def set_traveled_distance(traveled_distance)
    @trip_repository.update(@trip, traveled_distance: traveled_distance)
  end

  def set_destination_station
    @trip_repository.update(@trip, destination_station: @destination_station.id)
  end

  def set_finished_at
    @trip_repository.update(@trip, finished_at: Time.now)
  end

  def notify_subscribers
    @trip_subscriber.notify_big_data(@trip.id)
  end
end