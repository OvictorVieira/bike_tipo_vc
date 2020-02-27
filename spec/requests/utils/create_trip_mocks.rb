class CreateTripMocks
  class << self

    def create_mocks
      (0..10).each do
        FactoryBot.create(:bike, code: Faker::Code.ean)
        FactoryBot.create(:user, name: Faker::Name.name)
        FactoryBot.create(:station, name: Faker::Name.name,
                          latitude: Faker::Number.negative,
                          longitude: Faker::Number.positive)
      end

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
  end
end