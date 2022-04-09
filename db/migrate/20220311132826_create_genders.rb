# Model that stores selectable genders
class CreateGenders < ActiveRecord::Migration[7.0]
  def change
    create_table :genders do |t|
      t.string :label_de
      t.string :label_en

      t.timestamps
    end
  end
end
