class Station < ApplicationRecord

  validates_presence_of :name, :latitude, :longitude

  has_many :trips
end
