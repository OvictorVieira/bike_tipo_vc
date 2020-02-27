class TripCreateCommand

  def initialize(params)
    @bike_id = params[:bike_id]
    @user_id = params[:user_id]
    @origin_station = params[:origin_station]
  end

  def create!
    trip_repository.create!(trip_attributes)
  end

  private

  attr_reader :bike_id, :user_id, :origin_station

  def trip_repository
    TripRepository
  end

  def trip_attributes
    {
      bike_id: bike_id,
      user_id: user_id,
      origin_station: origin_station,
      started_at: Time.now.to_datetime
    }
  end
end