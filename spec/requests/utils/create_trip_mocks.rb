class CreateTripMocks
  class << self

    def create_bike_mocks
      random_station = Station.all[rand(0..10)]
      (0..10).each do  FactoryBot.create(:bike,
                                         code: Faker::Code.ean,
                                         station: random_station)
      end
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
        random_bike = Bike.all[rand(0..10)]
        random_user = User.all[rand(0..10)]
        random_origin_station = Station.all[rand(0..10)]
        random_destination_station = Station.all[rand(0..10)]

        FactoryBot.create(:trip,
                          bike: random_bike,
                          user: random_user,
                          origin_station: random_origin_station.id,
                          destination_station: random_destination_station.id)
      end
    end

    def create_trip_in_progress
      (0..10).each do
        random_bike = Bike.all[rand(0..10)]
        random_user = User.all[rand(0..10)]
        random_origin_station = Station.all[rand(0..10)]

        FactoryBot.create(:trip,
                          bike: random_bike,
                          user: random_user,
                          origin_station: random_origin_station.id,
                          traveled_distance: nil)
      end
    end
  end
end