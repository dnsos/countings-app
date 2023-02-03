class CountingAreasController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: %i[show]

  before_action :set_counting
  before_action :set_counting_areas, only: %i[index]
  before_action :set_counting_signups, only: %i[index]
  before_action :set_counting_area, only: %i[show]

  def index
    respond_to do |format|
      format.json do
        # Quoting the counting ID prevents SQL injections into the heredoc down below:
        quoted_counting_id = ActiveRecord::Base.connection.quote(@counting.id)

        # Heredoc of raw SQL that builds and generates GeoJSON representation:
        query_for_geojson_output = <<~SQL.squish
        SELECT
          json_build_object(
            'type', 'FeatureCollection',
            'features', json_agg(ST_AsGeoJSON(temp_counting_areas.*)::json)
          )
          FROM
          (
            -- We use a subquery to not have the irrelevant columns as output:
            SELECT id, name, geometry
            FROM counting_areas
            WHERE counting_areas.counting_id = #{quoted_counting_id}
          ) AS temp_counting_areas;
        SQL

        # Returns all rows (in this case just one) as a hash:
        query_result =
          ActiveRecord::Base.connection.execute(query_for_geojson_output)

        # For some reason the json_build_object key is present in the output,
        # that's why we have to access its value which is the actual GeoJSON structure:
        render json: query_result.first['json_build_object']
      end

      format.html do
        # Automatically finds the HTML view
      end
    end
  end

  def show
    respond_to do |format|
      format.json do
        # Quoting the ID prevents SQL injections into the heredoc down below:
        quoted_area_id = ActiveRecord::Base.connection.quote(params[:id])

        # Heredoc of raw SQL that builds and generates GeoJSON representation:
        query_for_geojson_output = <<~SQL.squish
        SELECT ST_AsGeoJSON(temp_counting_area.*)
          FROM
          (
            -- We use a subquery to not have the irrelevant columns as output:
            SELECT id, name, geometry
            FROM counting_areas
            WHERE counting_areas.id = #{quoted_area_id}
            LIMIT 1
          ) AS temp_counting_area;
        SQL

        # Returns all rows (in this case just one) as a hash:
        query_result =
          ActiveRecord::Base.connection.execute(query_for_geojson_output)

        # For some reason the st_asgeojson key is present in the output,
        # that's why we have to access its value which is the actual GeoJSON structure:
        render json: query_result.first['st_asgeojson']
      end

      format.html do
        # Automatically finds the HTML view
      end
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  # Retrieves all counting areas for the associated counting:
  def set_counting_areas
    @counting_areas = @counting.counting_areas

    @unassigned_counting_areas = @counting_areas.where.missing(:area_assignment)

    # For the assignment form in the view, we only need minimal information for the select options:
    @minimal_unassigned_counting_areas =
      @unassigned_counting_areas.map { |area| [area.name, area.id] }
  end

  # Retrieves all counting signups for the associated counting:
  def set_counting_signups
    @counting_signups = @counting.counting_signups

    # For the assignment form in the view, we only need minimal information for the select options:
    @minimal_counting_signups =
      @counting_signups.map { |signup| [signup.user.email, signup.id] }
  end

  def set_counting_area
    @counting_area = CountingArea.find(params[:id])
  end
end
