# The countees table will hold mostly references to other tables.
# Only counting_id and district_id are required.
class CreateCountees < ActiveRecord::Migration[7.0]
  def change
    create_table :countees do |t|
      t.references :counting, null: false, foreign_key: true
      t.references :district, null: false, foreign_key: true
      t.references :gender, foreign_key: true
      t.references :age_group, foreign_key: true
      t.integer :pet_count

      t.timestamps
    end
  end
end
