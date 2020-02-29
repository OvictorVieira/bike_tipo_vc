class BikeMaintenanceRepository

  class << self

    def maintenance_bikes(bike_id)
      BikeMaintenance
        .where(bike_id: bike_id)
        .where(finished_at: nil)
    end
  end
end