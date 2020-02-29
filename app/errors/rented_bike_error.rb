class RentedBikeError < StandardError

  def initialize
    super(I18n.t('trips.error.ranted_bike_error'))
  end
end