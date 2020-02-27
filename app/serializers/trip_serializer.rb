class TripSerializer < ApplicationSerializer

  include DateFormatter

  attributes :user_id, :bike_id, :started_at, :finished_at, :traveled_distance, :origin_station, :destination_station

  def started_at
    date_to_y_m_d_h_m_s(self.object.started_at)
  end

  def finished_at
    date_to_y_m_d_h_m_s(self.object.finished_at)
  end
end