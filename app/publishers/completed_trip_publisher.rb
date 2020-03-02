class CompletedTripPublisher

  include Wisper::Publisher

  def call(trip_id)
    broadcast(:notify, trip_id)
  end
end