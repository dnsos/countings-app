class Gender < ApplicationRecord
  validates :label_de, :label_en, presence: true
end
