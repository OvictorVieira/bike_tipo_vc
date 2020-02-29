class BikeRepository

  class << self

    def all
      Bike.all
    end

    def find_by_id(id)
      Bike.find(id)
    end

  end
end