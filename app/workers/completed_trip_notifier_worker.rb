class CompletedTripNotifierWorker

  include Sidekiq::Worker

  sidekiq_options retry: 3, backtrace: true

  def perform(trip_id)
    trip = TripRepository.find_by_id(trip_id)

    return if trip.notification_delivered?

    NotifyFinishTripToBigDataFacade.notify!(trip)

    notification_delivered_command = MarkNotificationAsDeliveredCommand.new(TripRepository)

    notification_delivered_command.mark_as_delivered(trip)
  end
end