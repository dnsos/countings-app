# District model
class District < ApplicationRecord
  validates :name, :geometry, presence: true

  has_many :countees

  scope :contains_point?,
    ->(latitude, longitude) {
      unless latitude.is_a?(Float) && longitude.is_a?(Float)
        raise ArgumentError, "Please provide floats as params"
      end
      if latitude.present? && longitude.present?
        District.where(
          [
            "ST_Contains(geometry::geometry, ST_GeomFromText('POINT (? ?)', 4326))",
            longitude,
            latitude
          ]
        )
      end
    }
end
