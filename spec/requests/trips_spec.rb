require 'rails_helper'

include DateFormatter

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

    it 'returns 200 when GET as HTML' do
      get trips_path

      expect(response).to be_successful
    end

    it 'returns a list of trips as JSON' do
      get trips_path, headers: { 'ACCEPT': 'application/json'}

      trips_created_mock = JsonHelper.json_loader('spec/requests/mocks/trips_created.json')
      parsed_trips_created_mock = JsonHelper.json_parser(trips_created_mock)
      response_body = JsonHelper.json_parser(response.body)

      expect(response).to be_successful
      expect(response.content_type).to eql('application/json; charset=utf-8')
      expect(response_body.count).to eql parsed_trips_created_mock.count
    end

  end

  describe "GET /trips/:id" do

    it 'returns 200 when GET on GET trip HTML' do
      get trip_path(Trip.all[rand(0..10)].id)

      expect(response).to be_successful
    end

    it 'return a trip as JSON' do
      trip = Trip.all[rand(0..10)]

      get trip_path(trip.id), headers: { 'ACCEPT': 'application/json'}

      response_body = JsonHelper.json_parser(response.body)

      expect(response).to be_successful
      expect(response.content_type).to eql('application/json; charset=utf-8')

      expect(response_body['id']).to eql trip.id

      # expect(response_body['started_at']).to eql date_to_y_m_d_h_m_s(trip.started_at)
      # expect(response_body['finished_at']).to eql date_to_y_m_d_h_m_s(trip.finished_at)

      expect(response_body['traveled_distance']).to eql trip.traveled_distance
      expect(response_body['origin_station']).to eql trip.origin_station
      expect(response_body['destination_station']).to eql trip.destination_station
      expect(response_body['bike_id']).to eql trip.bike_id
      expect(response_body['user_id']).to eql trip.user_id
    end
  end
end
