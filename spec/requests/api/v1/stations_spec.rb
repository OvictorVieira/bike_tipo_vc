require 'rails_helper'
require_relative '../../utils/create_trip_mocks'

include DateFormatter

RSpec.describe 'Api::V1::Stations', type: :request do

  describe 'GET /api/v1/stations' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_bike_mocks
    end

    context 'when station list returns successfully' do

      it 'returns a list of stations' do
        get api_v1_stations_path, headers: { 'ACCEPT': 'application/json'}

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to be_successful
        expect(response.content_type).to eql('application/json; charset=utf-8')

        response_body.each do |station|
          expect(station['name']).to be_present
          expect(station['latitude']).to be_present
          expect(station['longitude']).to be_present
          expect(station['vacancies']).to be_present
          expect(station['qty_bikes_available']).to be_present
          expect(station['qty_vacancies_available']).to be_present
        end
      end
    end
  end
end