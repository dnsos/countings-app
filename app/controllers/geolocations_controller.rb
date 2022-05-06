# GeolocationsController
class GeolocationsController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_district_with_stats, only: %i[index]

  def index; end

  private

  def set_district_with_stats
    @counting = Counting.find(params[:counting_id])

    # We use ActiveRecord's `quote` method to sanitize the input for the SQL query. TREAT CAREFULLY!
    sanitized_counting_id = ActiveRecord::Base.connection.quote(@counting.id)

    # All district with stats of the current counting
    # ----------------
    # Slightly more complex SQL query to retrieve each Berlin district, along with the number of counted people.
    @districts_with_stats =
      District
        .joins(
          "LEFT OUTER JOIN geolocations ON geolocations.district_id = districts.id AND geolocations.counting_id = #{sanitized_counting_id}",
        )
        .select(
          'districts.id, districts.name, districts.geometry, COUNT(geolocations.*) AS counted_people',
        )
        .group('districts.id, districts.name, geolocations.counting_id')
  end
end
