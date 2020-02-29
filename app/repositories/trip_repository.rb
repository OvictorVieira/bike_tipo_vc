class TripRepository
  class << self

    def all
      Trip.all
    end

    def find_by_id(id)
      Trip.find(id)
    end

    def create!(**attributes)
      Trip.create!(attributes)
    end

    def update(**attributes)
      Trip.update(attributes)
    end

    def unfinished_bike_trip(bike_id)
      Trip.where(bike_id: bike_id, finished_at: nil)
    end
  end
end