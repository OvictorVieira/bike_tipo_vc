class CreateTripFacade

  class << self

    include CreateTripPolicy

    def create!(bike_id, user_id, origin_station)
      raise RentBikesUnderMaintenanceError if bike_under_maintenance?(bike_id)

      raise RentedBikeError if bike_already_rented?(bike_id)

      create_trip_command = CreateTripCommand.new(TripRepository)

      create_trip_command.create!(bike_id, user_id, origin_station)
    end
  end
end