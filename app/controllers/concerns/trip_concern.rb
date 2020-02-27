module TripConcern

  def load_trip
    @trip = TripRepository.find_by_id(params[:id])
  end

  def trip_params
    params.fetch(:trip)
  end
end