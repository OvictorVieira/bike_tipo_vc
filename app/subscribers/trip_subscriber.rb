class TripSubscriber

  class << self

    def notify_big_data(trip_id)
      notify_completion(trip_id)
    end

    private

    def notify_completion(trip_id)
      completed_trip_publisher = CompletedTripPublisher.new

      completed_trip_publisher.subscribe(CompletedTripService)

      completed_trip_publisher.call(trip_id)
    end
  end
end