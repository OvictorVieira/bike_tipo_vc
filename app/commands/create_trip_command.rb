class TripCreateCommand

  class << self

    def create!(bike_id, user_id, origin_station)
      trip_repository.create!(bike_id: bike_id,
                              user_id: user_id,
                              origin_station: origin_station,
                              started_at: Time.now)
    end

    private

    def trip_repository
      TripRepository
    end
  end
end