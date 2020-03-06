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

      CompletedTripNotifierWorker.clear
    end

    let(:user) { User.first }

    context 'when finish trip' do

      it 'returns success when notifying big data API' do

        assert_equal 0, CompletedTripNotifierWorker.jobs.size

        use_fourth_trip_id_created = Trip.all[4]
        use_seventh_station_id_created = Station.all[7]

        valid_params = {
          'trip' => {
            destination_station: use_seventh_station_id_created.id
          }
        }

        put api_v1_finish_path(use_fourth_trip_id_created.id), headers: { 'X-User-Email': user.email,
                                                                          'X-User-Token': user.authentication_token },
                                                               params: valid_params

        expect(response).to have_http_status(:ok)

        completed_trip_notifier_jobs = CompletedTripNotifierWorker.jobs

        completed_trip_notifier_jobs.each do |job|
          completed_trip_notifier = job['class'].constantize

          VCR.use_cassette 'worker/completed_trip_notifier_worker_success' do

            completed_trip_notifier.perform_async(job['args'].first)
            CompletedTripNotifierWorker.drain
          end
        end

        use_fourth_trip_id_created.reload

        expect(use_fourth_trip_id_created.notification_delivered).to be_truthy
      end

      it 'returns unauthorized when notifying big data API', :vcr do

        assert_equal 0, CompletedTripNotifierWorker.jobs.size

        use_fourth_trip_id_created = Trip.all[4]
        use_seventh_station_id_created = Station.all[7]

        valid_params = {
          'trip' => {
            destination_station: use_seventh_station_id_created.id
          }
        }

        put api_v1_finish_path(use_fourth_trip_id_created.id), headers: { 'X-User-Email': user.email,
                                                                          'X-User-Token': user.authentication_token },
                                                               params: valid_params

        expect(response).to have_http_status(:ok)

        completed_trip_notifier_jobs = CompletedTripNotifierWorker.jobs

        completed_trip_notifier_jobs.each do |job|
          completed_trip_notifier = job['class'].constantize

          expect {

            VCR.use_cassette 'worker/completed_trip_notifier_worker_unauthorized' do

              completed_trip_notifier.perform_async(job['args'].first)
              CompletedTripNotifierWorker.drain
            end
          }.to raise_error BigData::Errors::UnauthorizedError
        end

        use_fourth_trip_id_created.reload
        
        expect(use_fourth_trip_id_created.notification_delivered).to be_falsey
      end
    end
  end
end