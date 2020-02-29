module CreateTripPolicy

  def bike_under_maintenance?(bike_id)
    maintenance_bikes = BikeMaintenanceRepository.maintenance_bikes(bike_id)

    maintenance_bikes.present?
  end
end