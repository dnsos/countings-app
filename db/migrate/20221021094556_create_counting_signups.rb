class CreateCountingSignups < ActiveRecord::Migration[7.0]
  def change
    create_table :counting_signups do |t|
      t.references :counting, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps

      # A user may only signup for a counting once:
      t.index %i[counting_id user_id], unique: true
    end
  end
end
