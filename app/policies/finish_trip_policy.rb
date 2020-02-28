module FinishTripPolicy

  def destination_is_origin_station?(origin_station, destination_station)
    origin_station == destination_station
  end

end