class Person < ApplicationRecord
  belongs_to :age_group
  belongs_to :gender
  belongs_to :counting

  validates :pet_count, numericality: { greater_than_or_equal_to: 0 }
end
