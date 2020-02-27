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

      render json: { status: :not_found }
    end
  end

  private

    include TripConcern
end