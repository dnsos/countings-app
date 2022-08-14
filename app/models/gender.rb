class Gender < ApplicationRecord
  include Translatable

  validates :label_de, :label_en, presence: true

  has_many :countees

  translates :label
end
