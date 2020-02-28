class Api::V1::TripsController < ApplicationController

  before_action :trip_params, only: [:create, :update]

  def index
    trips = TripRepository.all

    render json: trips, status: :ok, each_serializer: TripSerializer
  end

  def show
    begin
      load_trip

      render json: @trip, status: :ok

    rescue ActiveRecord::RecordNotFound

      render json: { message: I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('trips.label.trip')) },
             status: :not_found
    end
  end

  def create
    begin
      create_trip_command = CreateTripCommand.new(TripRepository)

      trip_created = create_trip_command
                       .create!(params[:bike_id],
                                params[:user_id],
                                params[:origin_station])

      render json: trip_created, status: :created

    rescue ActiveRecord::RecordInvalid, ActiveRecord::InvalidForeignKey

      render json: { message: I18n.t('activerecord.errors.messages.invalid_fields') },
             status: :unprocessable_entity
    end
  end

  def finish
    begin
      load_trip

      finish_trip = FinishTripBuilder.new(@trip.load_origin_station, params[:destination_station])

      finish_trip.build(@trip)

      render json: @trip, status: :ok

    rescue FinishAtOriginStationError => error

      render json: { message: error.message },
             status: :unprocessable_entity

    rescue ActiveRecord::RecordNotFound

      render json: { message: I18n.t('activerecord.errors.messages.record_not_found', model_type: I18n.t('trips.label.trip')) },
             status: :not_found
    end
  end

  private

    include TripConcern
end