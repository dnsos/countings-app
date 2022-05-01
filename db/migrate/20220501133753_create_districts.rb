# The districts table will hold geographic information about each Berlin district
class CreateDistricts < ActiveRecord::Migration[7.0]
  def change
    create_table :districts do |t|
      # geographic: true implies that SRID is 4326:
      t.multi_polygon :geometry, geographic: true, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
