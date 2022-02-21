# Adds a reference user_id to the countings table
class AddUserRefToCountings < ActiveRecord::Migration[7.0]
  def change
    add_reference :countings, :user, null: false, foreign_key: true
  end
end
