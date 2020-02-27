class Api::V1::TripsController < ApplicationController

  def index
    trips = TripRepository.all

    render json: trips, each_serializer: TripSerializer
  end

  def show
    begin
      load_trip

      render json: @trip
    rescue ActiveRecord::RecordNotFound

      render json: { message: I18n.t('activerecord.errors.messages.record_not_found') },
             status: :not_found
    end
  end

  def create
    begin
      trip_creator = TripCreator.new(params)

      trip_created = trip_creator.create_trip

      render json: trip_created, status: :created
    rescue => error
      render json: { message: error.message },
             status: :unprocessable_entity
    end
  end

  private

    include TripConcern
end