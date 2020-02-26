require 'rails_helper'

RSpec.describe "Trips", type: :request do

  before do
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

  describe "GET /trips" do

    it "returns 200 when GET on trips_path" do
      get trips_path

      expect(response).to be_successful
    end

    it "returns a list of trips" do
      get trips_path

      expect(response).to be_successful
    end

  end

  describe "GET /trips/:id" do

    it "returns 200 when GET on trip_path" do
      get trip_path(Trip.all[rand(0..10)].id)

      expect(response).to be_successful
    end
  end
end
