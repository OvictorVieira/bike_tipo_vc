class NotifyFinishTripToBigDataFacade

  class << self

    def notify!(trip)
      communication_base = Core::Communicator.new(BigData::Api::Communicator::URL_BASE,
                                                  BigData::Api::Communicator::TRIPS_END_POINT)

      big_data_communication = BigData::Api::Communicator.new(communication_base)

      body = mount_body(trip)

      big_data_communication.post(body)
    end

    private

    def mount_body(trip)
      {
        "user_id": trip.user_id,
        "bike_id": trip.bike_id,
        "started_at": trip.started_at,
        "finished_at": trip.finished_at,
        "traveled_distance": trip.traveled_distance,
        "origin": {
          "station_id": trip.origin_station
        },
        "destination": {
          "station_id": trip.destination_station
        }
      }
    end
  end
end