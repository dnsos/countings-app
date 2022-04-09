# Model that stores selectable age groups
class CreateAgeGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :age_groups do |t|
      t.integer :min_age
      t.integer :max_age

      t.timestamps
    end
  end
end
