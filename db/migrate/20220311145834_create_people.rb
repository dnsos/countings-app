# Model for storing people encountered in countings
class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.references :counting, null: false, foreign_key: true
      t.references :age_group, null: false, foreign_key: true
      t.references :gender, null: false, foreign_key: true
      t.integer :pet_count, default: 0

      t.timestamps
    end
  end
end
