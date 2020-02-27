require 'rails_helper'
require_relative './utils/create_trip_mocks'

include DateFormatter

RSpec.describe "Trips", type: :request do

  before do
    CreateTripMocks.create_bike_mocks
    CreateTripMocks.create_user_mocks
    CreateTripMocks.create_station_mocks
    CreateTripMocks.create_trip_mocks
  end

  describe "GET /trips" do

    it 'returns a list of trips' do
      get trips_path

      expect(response).to be_successful
    end
  end

  describe "GET /trips/:id" do

    it 'return a trip as JSON' do
      trip = Trip.all[rand(0..10)]

      get trip_path(trip.id)

      expect(response).to be_successful
    end
  end
end
