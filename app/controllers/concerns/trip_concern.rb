module TripConcern

  def load_trip
    @trip = TripRepository.find_by_id(params[:id])
  end

  def trip_params
    params.permit(:user_id, :bike_id, :origin_station, :destination_station)
  end
end