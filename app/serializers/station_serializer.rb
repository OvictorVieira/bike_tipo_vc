class StationSerializer < ApplicationSerializer

  attributes :name, :latitude, :longitude, :vacancies, :qty_bikes_available, :qty_vacancies_available

  def qty_bikes_available
    @qty_bikes_available = self.object.bikes.available.count
  end

  def qty_vacancies_available
    self.object.vacancies - @qty_bikes_available
  end
end