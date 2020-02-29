require 'rails_helper'
require_relative '../requests/utils/create_trip_mocks'
require 'sidekiq/testing'

include DateFormatter

RSpec.describe CompletedTripNotifierWorker, type: :request do

  describe 'stack worker to notify big data' do

    before do
      CreateTripMocks.create_station_mocks
      CreateTripMocks.create_bike_mocks
      CreateTripMocks.create_user_mocks
      CreateTripMocks.create_trip_in_progress
    end

    xcontext 'when finish trip' do

      it 'returns success when notifying big data API' do

        # TODO Necessário avaliar o header da request

        use_fourth_trip_id_created = Trip.all[4]
        use_seventh_station_id_created = Station.all[7]

        valid_params = {
          destination_station: use_seventh_station_id_created.id
        }

        put api_v1_finish_path(use_fourth_trip_id_created.id), params: valid_params

        expect(response).to have_http_status(:ok)

        completed_trip_notifier_jobs = CompletedTripNotifierWorker.jobs

        completed_trip_notifier_jobs.each do |job|
          completed_trip_notifier = job['class'].constantize

          completed_trip_notifier.new.perform(job['args'].first)
        end
      end

      it 'returns unauthorized when notifying big data API', :vcr do

        use_fourth_trip_id_created = Trip.all[4]
        use_seventh_station_id_created = Station.all[7]

        valid_params = {
          destination_station: use_seventh_station_id_created.id
        }

        put api_v1_finish_path(use_fourth_trip_id_created.id), params: valid_params

        expect(response).to have_http_status(:ok)

        completed_trip_notifier_jobs = CompletedTripNotifierWorker.jobs

        completed_trip_notifier_jobs.each do |job|
          completed_trip_notifier = job['class'].constantize

          expect {

            completed_trip_notifier.new.perform(job['args'].first)

          }.to raise_error BigData::Errors::UnauthorizedError
        end
      end
    end
  end
end