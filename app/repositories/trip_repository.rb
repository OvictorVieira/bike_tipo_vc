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
  end
end