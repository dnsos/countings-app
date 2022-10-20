class CreateCountingAreas < ActiveRecord::Migration[7.0]
  def change
    create_table :counting_areas do |t|
      t.string :name
      t.multi_polygon :geometry, geographic: true, null: false
      t.belongs_to :counting, null: false, foreign_key: true

      t.timestamps
    end
  end
end
