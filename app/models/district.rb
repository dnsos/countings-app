class District < ApplicationRecord
  validates :name, :geometry, presence: true

  has_many :geolocations
end
