class CreateBikeMaintenanceMocks

  class << self

    def create_bike_maintenance_for_a(bike_id)
      (0..4).map do
        FactoryBot.create(:bike_maintenance, bike_id: bike_id)
      end
    end
  end
end