# We no longer assign a countee to a district. Instead, we now use the
# more granular counting area.
class RemoveDistrictFromCountee < ActiveRecord::Migration[7.0]
  def change
    remove_column :countees, :district_id, :number
  end
end
