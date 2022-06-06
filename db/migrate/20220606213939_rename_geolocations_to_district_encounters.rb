# More appropriate name for what's in this table
class RenameGeolocationsToDistrictEncounters < ActiveRecord::Migration[7.0]
  def change
    rename_table :geolocations, :district_encounters
  end
end
