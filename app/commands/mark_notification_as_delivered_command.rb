class MarkNotificationAsDeliveredCommand

  def initialize(trip_repository)
    @trip_repository = trip_repository
  end

  def mark_as_delivered(trip)
    @trip_repository.update(trip, notification_delivered: true)
  end
end