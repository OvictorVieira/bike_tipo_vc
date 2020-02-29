class CompletedTripNotifierCommand

  class << self

    def notify(trip_id)

      CompletedTripNotifierWorker.perform_in(random_ten_minute_interval, trip_id)
    end

    private

    def random_ten_minute_interval
      rand(0..10 * 60)
    end
  end
end