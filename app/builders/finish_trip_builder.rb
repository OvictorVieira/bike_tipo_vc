class FinishTripBuilder

  include FinishTripPolicy

  def initialize(origin_station, destination_station_id)
    @origin_station = origin_station
    @destination_station = StationRepository.find_by_id(destination_station_id)
  end

  def build(trip)
    raise FinishAtOriginStationError if destination_is_origin_station? @origin_station.id, @destination_station.id

    finish_trip_command = FinishTripCommand.new(trip, TripRepository, @destination_station)

    traveled_distance = DistanceCalculatorCommand.calculate_distance(@origin_station.latitude,
                                                                     @origin_station.longitude,
                                                                     @destination_station.latitude,
                                                                     @destination_station.longitude)

    finish_trip_command.finish!(traveled_distance)
  end
end