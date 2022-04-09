class Gender < ApplicationRecord
  include Translatable

  validates :label_de, :label_en, presence: true

  has_many :people

  translates :label
end
