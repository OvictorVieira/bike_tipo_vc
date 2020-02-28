require 'rails_helper'
require_relative '../../utils/create_trip_mocks'

include DateFormatter

RSpec.describe 'Api::V1::Trips', type: :request do

  describe 'GET /api/v1/trips' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_user_mocks
      CreateTripMocks.create_bike_mocks
      CreateTripMocks.create_complete_trip_mocks
    end

    context 'when trip list returns successfully' do

      it 'returns a list of trips' do
        get api_v1_trips_path, headers: { 'ACCEPT': 'application/json'}

        trips_created_mock = JSONHelper.json_loader('spec/requests/mocks/trips_created.json')
        parsed_trips_created_mock = JSONHelper.json_parser(trips_created_mock)
        response_body = JSONHelper.json_parser(response.body)

        expect(response).to be_successful
        expect(response.content_type).to eql('application/json; charset=utf-8')
        expect(response_body.count).to eql parsed_trips_created_mock.count
      end
    end

  end

  describe 'GET /api/v1/trips/:id' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_user_mocks
      CreateTripMocks.create_bike_mocks
      CreateTripMocks.create_complete_trip_mocks
    end

    context 'when record is found' do

      it 'return a trip' do
        trip = Trip.all[rand(0..10)]

        get api_v1_trip_path(trip.id), headers: { 'ACCEPT': 'application/json'}

        response_body = JSONHelper.json_parser(response.body)

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
    end

    context 'when record is not found' do

      it 'return not_found' do
        get api_v1_trip_path(-1), headers: { 'ACCEPT': 'application/json'}

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to be_not_found
        expect(response.content_type).to eql('application/json; charset=utf-8')
        expect(response_body['message']).to eql(I18n.t('activerecord.errors.messages.record_not_found',
                                                       model_type: I18n.t('trips.label.trip')))
      end
    end
  end

  describe 'POST /api/v1/trips' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_user_mocks
      CreateTripMocks.create_bike_mocks
    end

    context 'when record is created' do

      it 'return a created trip' do
        random_user_id = -> { User.all[rand(0..10)].id }
        random_bike_id = -> { Bike.all[rand(0..10)].id }
        random_station_id = -> { Station.all[rand(0..10)].id }

        valid_params = {
          user_id: random_user_id.call,
          bike_id: random_bike_id.call,
          origin_station: random_station_id.call
        }

        post '/api/v1/trips',
             headers: { 'ACCEPT': 'application/json'},
             params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:created)
        expect(response_body).to be_present
      end
    end

    context 'when record is unprocessable entity' do

      it 'when creating trip with invalid user_id' do
        nonexistent_user_id = -> { -1 }
        random_bike_id = -> { Bike.all[rand(0..10)].id }
        random_station_id = -> { Station.all[rand(0..10)].id }

        valid_params = {
          user_id: nonexistent_user_id.call,
          bike_id: random_bike_id.call,
          origin_station: random_station_id.call
        }

        post '/api/v1/trips',
             headers: { 'ACCEPT': 'application/json'},
             params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['message']).to eql I18n.t('activerecord.errors.messages.invalid_fields')
      end

      it 'when creating trip with invalid bike_id' do
        random_user_id = -> { User.all[rand(0..10)].id }
        nonexistent_bike_id = -> { -1 }
        random_station_id = -> { Station.all[rand(0..10)].id }

        valid_params = {
          user_id: random_user_id.call,
          bike_id: nonexistent_bike_id.call,
          origin_station: random_station_id.call
        }

        post '/api/v1/trips',
             headers: { 'ACCEPT': 'application/json'},
             params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['message']).to eql I18n.t('activerecord.errors.messages.invalid_fields')
      end

      it 'when creating trip with invalid station_id' do
        random_user_id = -> { User.all[rand(0..10)].id }
        random_bike_id = -> { Bike.all[rand(0..10)].id }
        nonexistent_station_id = -> { -1 }

        valid_params = {
          user_id: random_user_id.call,
          bike_id: random_bike_id.call,
          origin_station: nonexistent_station_id.call
        }

        post '/api/v1/trips',
             headers: { 'ACCEPT': 'application/json'},
             params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['message']).to eql I18n.t('activerecord.errors.messages.invalid_fields')
      end
    end

    context 'when record is ' do

      it 'when bike is under maintenance' do
        random_user_id = -> { -1 }
        random_bike_id = -> { Bike.all[rand(0..10)].id }
        random_station_id = -> { Station.all[rand(0..10)].id }

        valid_params = {
          user_id: random_user_id.call,
          bike_id: random_bike_id.call,
          origin_station: random_station_id.call
        }

        post '/api/v1/trips',
             headers: { 'ACCEPT': 'application/json'},
             params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['message']).to eql I18n.t('activerecord.errors.messages.invalid_fields')
      end
    end

  end

  describe 'PUT /api/v1/trips/:id' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_bike_mocks
      CreateTripMocks.create_user_mocks
      CreateTripMocks.create_trip_in_progress
    end

    context 'when finish trip' do

      it 'returns a successfully completed trip' do

        use_third_trip_id_created = -> { Trip.all[3] }
        use_fifth_station_id_created = -> { Station.all[5].id }

        valid_params = {
          destination_station: use_fifth_station_id_created.call
        }

        trip = use_third_trip_id_created.call

        put api_v1_finish_path(trip.id), params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:ok)

        expect(response_body['user_id']).to eql trip.user_id
        expect(response_body['bike_id']).to eql trip.bike_id
        expect(response_body['started_at']).to eql date_to_y_m_d_h_m_s(trip.started_at)
        expect(response_body['finished_at']).to eql date_to_y_m_d_h_m_s(trip.finished_at)
        expect(response_body['traveled_distance']).to eql trip.traveled_distance
        expect(response_body['origin_station']).to eql trip.origin_station
        expect(response_body['destination_station']).to eql trip.destination_station
      end

      it 'returns not found' do

        use_fifth_station_id_created = -> { Station.all[5].id }

        valid_params = {
          destination_station: use_fifth_station_id_created.call
        }

        put api_v1_finish_path(-1), params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:not_found)

        expect(response_body['message']).to eql I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('trips.label.trip'))
      end

      it 'returns unprocessable_entity when delivering bike at origin_station' do

        use_third_trip_id_created = -> { Trip.all[3] }

        trip = use_third_trip_id_created.call

        valid_params = {
          destination_station: trip.origin_station
        }

        put api_v1_finish_path(trip.id), params: valid_params

        response_body = JSONHelper.json_parser(response.body)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response_body['message']).to eql I18n.t('trips.error.finish_at_origin_station_error')
      end
    end

  end
end