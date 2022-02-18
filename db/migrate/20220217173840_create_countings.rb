# Creates a countings table
class CreateCountings < ActiveRecord::Migration[7.0]
  def change
    create_table :countings do |t|
      t.string :title, null: false
      t.text :description
      t.timestamp :starts_at, null: false
      t.timestamp :ends_at, null: false

      t.timestamps
    end
  end
end
