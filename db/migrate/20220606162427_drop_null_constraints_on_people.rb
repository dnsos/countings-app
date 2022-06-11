# We want to allow partial people information to be saved as well. That's why we make the gender_id and age_group_id columns nullable.
class DropNullConstraintsOnPeople < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:people, :gender_id, true)
    change_column_null(:people, :age_group_id, true)
  end
end
