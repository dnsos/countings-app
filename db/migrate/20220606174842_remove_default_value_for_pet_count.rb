# Maybe a person does not provide information about their pet_count. In that case we don't want to just assume a pet_count of zero.
class RemoveDefaultValueForPetCount < ActiveRecord::Migration[7.0]
  def change
    change_column_default :people, :pet_count, nil
  end
end
