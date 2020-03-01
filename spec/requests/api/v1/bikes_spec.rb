require 'rails_helper'
require_relative '../../utils/create_trip_mocks'

include DateFormatter

RSpec.describe 'Api::V1::Bikes', type: :request do

  login_user

  describe 'GET /api/v1/bikes' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_bike_mocks
    end

    context 'when station list returns successfully' do

      it 'returns a list of bikes' do
        get api_v1_bikes_path, headers: { 'ACCEPT': 'application/json'}

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to be_successful
        expect(response.content_type).to eql('application/json; charset=utf-8')

        response_body.each do |bike|
          expect(bike['code']).to be_present
          expect(bike['station_id']).to be_present
          expect(bike['available']).to be_present
        end
      end
    end
  end
end