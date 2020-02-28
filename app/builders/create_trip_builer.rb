class CreateTripBuilder

  include CreateTripPolicy

  class << self

    def create!(bike_id, user_id, origin_station)
      create_trip_command = CreateTripCommand.new(TripRepository)

      raise RentBikesUnderMaintenanceError if ''

      create_trip_command.create!(bike_id, user_id, origin_station)
    end
  end
end