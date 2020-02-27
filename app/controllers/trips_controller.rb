class TripsController < ApplicationController

  before_action :load_trip, only: [:show]

  def index
    @trips = TripRepository.all
  end

  def show
  end

  private

    include TripConcern
end
