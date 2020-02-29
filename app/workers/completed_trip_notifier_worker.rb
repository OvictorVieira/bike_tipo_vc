class CompletedTripNotifierWorker

  include Sidekiq::Worker

  sidekiq_options retry: 3, backtrace: true

  def perform(trip_id)
    trip = TripRepository.find_by_id(trip_id)

    NotifyFinishTripToBigDataFacade.notify!(trip)
  end
end