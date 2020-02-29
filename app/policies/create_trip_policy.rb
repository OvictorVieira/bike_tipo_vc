module CreateTripPolicy

  def bike_under_maintenance?(bike_id)
    maintenance_bikes = BikeMaintenanceRepository.bike_maintenance_not_completed(bike_id)

    maintenance_bikes.present?
  end

  def bike_already_rented?(bike_id)
    unfinished_bike_trip = TripRepository.unfinished_bike_trip(bike_id)

    unfinished_bike_trip.present?
  end

  def bike_available?(bike_id)
    bike = BikeRepository.find_by_id(bike_id)

    bike.available?
  end
end