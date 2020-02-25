class Trip < ApplicationRecord

  belongs_to :bike
  belongs_to :user
  belongs_to :station
end
