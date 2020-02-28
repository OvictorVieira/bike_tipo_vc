class BikeMaintenance < ApplicationRecord

  validates_presence_of :reason, :bike_id

  has_many :bikes
end
