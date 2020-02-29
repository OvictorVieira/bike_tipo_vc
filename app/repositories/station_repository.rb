class StationRepository

  class << self

    def all
      Station.all
    end

    def find_by_id(id)
      Station.find(id)
    end
  end
end