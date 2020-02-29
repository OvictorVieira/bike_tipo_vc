class Bike < ApplicationRecord

  validates_presence_of :code, :station_id

  has_and_belongs_to_many :users, through: :trips
  belongs_to :station
  has_one :bike_maintenance

  scope :available, -> { where(available: true) }
end
