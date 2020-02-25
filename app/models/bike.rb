class Bike < ApplicationRecord

  validates_presence_of :code

  has_many :trips
end
