require 'rails_helper'
require_relative '../../utils/create_trip_mocks'

include DateFormatter

RSpec.describe "Api::V1::Trips", type: :request do

  before do
    CreateTripMocks.create_mocks
  end

  describe "GET /trips" do

    it 'returns a list of trips' do
      get api_v1_trips_path, headers: { 'ACCEPT': 'application/json'}

      trips_created_mock = JsonHelper.json_loader('spec/requests/mocks/trips_created.json')
      parsed_trips_created_mock = JsonHelper.json_parser(trips_created_mock)
      response_body = JsonHelper.json_parser(response.body)

      expect(response).to be_successful
      expect(response.content_type).to eql('application/json; charset=utf-8')
      expect(response_body.count).to eql parsed_trips_created_mock.count
    end

  end

  describe "GET /trips/:id" do

    it 'return a trip' do
      trip = Trip.all[rand(0..10)]

      get api_v1_trip_path(trip.id), headers: { 'ACCEPT': 'application/json'}

      response_body = JsonHelper.json_parser(response.body)

      expect(response).to be_successful
      expect(response.content_type).to eql('application/json; charset=utf-8')

      expect(response_body['user_id']).to eql trip.user_id
      expect(response_body['bike_id']).to eql trip.bike_id
      expect(response_body['started_at']).to eql date_to_y_m_d_h_m_s(trip.started_at)
      expect(response_body['finished_at']).to eql date_to_y_m_d_h_m_s(trip.finished_at)
      expect(response_body['traveled_distance']).to eql trip.traveled_distance
      expect(response_body['origin_station']).to eql trip.origin_station
      expect(response_body['destination_station']).to eql trip.destination_station
    end

    it 'return not_found' do
      get api_v1_trip_path(-1), headers: { 'ACCEPT': 'application/json'}

      response_body = JsonHelper.json_parser(response.body)

      expect(response).to be_successful
      expect(response.content_type).to eql('application/json; charset=utf-8')
      expect(response_body['status']).to eql('not_found')
    end
  end
end