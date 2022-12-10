class AddCountingAreaToCountee < ActiveRecord::Migration[7.0]
  def change
    add_reference :countees, :counting_area, null: false, foreign_key: true
  end
end
