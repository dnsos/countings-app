require "rgeo/geo_json"
require "json"

namespace :db do
  desc "Inserts counting areas into the database based on a source GeoJSON"
  task :insert_counting_areas,
    %i[geojson_path name_property counting_id] => :environment do |_, args|
    # All args are mandatory except the name_property:
    unless args.geojson_path.present?
      raise ArgumentError.new(
        "Please provide a path to the GeoJSON source file"
      )
    end
    unless args.counting_id.present?
      raise ArgumentError.new("Please provide a counting_id")
    end

    counting_areas_file = File.read(Rails.root.join(args.geojson_path))
    parsed_counting_areas_file = JSON.parse(counting_areas_file)

    # The counting areas should only be saved when every feature is successfully saved to the DB:
    CountingArea.transaction do
      parsed_counting_areas_file["features"].each do |feature|
        CountingArea.create! name: feature["properties"][args.name_property],
          geometry:
            RGeo::GeoJSON.decode(feature["geometry"]),
          counting_id: args.counting_id
      end
    end

    puts "✅ Successfully inserted #{parsed_counting_areas_file["features"].size} counting areas into the database."
  end
end
