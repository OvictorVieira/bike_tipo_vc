class CreateTripMocks
  class << self

    def create_bike_mocks
      (0..10).each { FactoryBot.create(:bike, code: Faker::Code.ean) }
    end

    def create_user_mocks
      (0..10).each { FactoryBot.create(:user, name: Faker::Name.name) }
    end

    def create_station_mocks
      (0..10).each do
        FactoryBot.create(:station, name: Faker::Name.name,
                          latitude: Faker::Number.negative,
                          longitude: Faker::Number.positive)
      end
    end

    def create_complete_trip_mocks
      (0..10).each do
        bike = Bike.all[rand(0..10)]
        user = User.all[rand(0..10)]
        origin_station = Station.all[rand(0..10)]
        destination_station = Station.all[rand(0..10)]

        FactoryBot.create(:trip, bike: bike, user: user,
                          origin_station: origin_station.id,
                          destination_station: destination_station.id)
      end
    end

    def create_trip_in_progress
      (0..10).each do
        bike = Bike.all[rand(0..10)]
        user = User.all[rand(0..10)]
        origin_station = Station.all[rand(0..10)]

        FactoryBot.create(:trip, bike: bike, user: user,
                          origin_station: origin_station.id,
                          traveled_distance: nil)
      end
    end
  end
end