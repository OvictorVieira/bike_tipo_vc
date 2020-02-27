class TripsController < ApplicationController

  before_action :load_trip, only: [:show]

  def index
    @trips = TripRepository.all

    respond_to do |format|
      format.html
      format.json { render json: @trips }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @trip }
    end
  end

  private

    def load_trip
      @trip = TripRepository.find_by_id(params[:id])
    end

    def trip_params
      params.fetch(:trip)
    end
end
