# We also want to have a description_long, so this migration needs to happen first.
class ChangeCountingsColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :countings, :description, :description_short
  end
end
