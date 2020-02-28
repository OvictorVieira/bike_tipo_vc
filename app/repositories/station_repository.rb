class StationRepository

  class << self

    def find_by_id(id)
      Station.find(id)
    end
  end
end