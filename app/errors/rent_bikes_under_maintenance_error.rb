class RentBikesUnderMaintenanceError < StandardError
  def initialize
    super(I18n.t('trips.error.rent_bikes_under_maintenance_error'))
  end
end