class BikeNotAvailableError < StandardError

  def initialize
    super(I18n.t('bikes.error.bike_not_available_error'))
  end
end