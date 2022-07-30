# District model
class District < ApplicationRecord
  validates :name, :geometry, presence: true

  has_many :countees

  scope :contains_point?,
        ->(latitude, longitude) {
          unless latitude.is_a?(Float) && longitude.is_a?(Float)
            raise ArgumentError, 'Please provide floats as params'
          end
          if latitude.present? && longitude.present?
            sanitized_latitude = ActiveRecord::Base.connection.quote(latitude)
            sanitized_longitude = ActiveRecord::Base.connection.quote(longitude)

            find_by_sql(
              "SELECT * FROM districts WHERE ST_Contains(geometry::geometry, ST_GeomFromText('POINT (#{sanitized_longitude} #{sanitized_latitude})', 4326))",
            )
          end
        }
end
