class BikeMaintenanceRepository

  class << self

    def bike_maintenance_not_completed(bike_id)
      BikeMaintenance
        .where(bike_id: bike_id)
        .where(finished_at: nil)
    end
  end
end