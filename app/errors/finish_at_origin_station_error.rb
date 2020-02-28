class FinishAtOriginStationError < StandardError

  def initialize
    super I18n.t('trips.error.finish_at_origin_station_error')
  end
end