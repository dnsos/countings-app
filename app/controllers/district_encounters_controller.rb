# DistrictEncountersController
class DistrictEncountersController < ApplicationController
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
          "LEFT OUTER JOIN district_encounters ON district_encounters.district_id = districts.id AND district_encounters.counting_id = #{sanitized_counting_id}",
        )
        .select(
          'districts.id, districts.name, districts.geometry, COUNT(district_encounters.*) AS people_count',
        )
        .group('districts.id, districts.name, district_encounters.counting_id')
        .order('people_count DESC')
  end
end
