class CreateAreaAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :area_assignments do |t|
      # A counting area is a unique area of each counting.
      # Therefore it can only be assigned once to one user/signup.
      t.references :counting_area, null: false, foreign_key: true, unique: true
      t.references :counting_signup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
