class CountingAreasController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_counting
  before_action :set_counting_area, only: %i[show]

  def index
    respond_to do |format|
      format.json do
        # Quoting the counting ID prevents SQL injections into the heredoc down below:
        quoted_counting_id = ActiveRecord::Base.connection.quote(@counting.id)

        # Heredoc of raw SQL that builds and generates GeoJSON representation:
        query_for_geojson_output = <<~SQL
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

      format.html { @counting_areas = @counting.counting_areas }
    end
  end

  def show
    respond_to do |format|
      format.json do
        # Quoting the ID prevents SQL injections into the heredoc down below:
        quoted_area_id = ActiveRecord::Base.connection.quote(params[:id])

        # Heredoc of raw SQL that builds and generates GeoJSON representation:
        query_for_geojson_output = <<~SQL
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

      format.html {}
    end
  end

  private

  def set_counting
    @counting = Counting.find(params[:counting_id])
  end

  def set_counting_area
    @counting_area = CountingArea.find(params[:id])
  end
end
