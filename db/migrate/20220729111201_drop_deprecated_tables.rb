# These resources were already removed from the codebase.
# Now the tables need to be dropped as well.
class DropDeprecatedTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :people
    drop_table :district_encounters
  end
end
