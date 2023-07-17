class AgeGroup < ApplicationRecord
  validates :min_age, presence: true
  validates :max_age,
    comparison: {
      greater_than: :min_age
    },
    unless: -> { max_age.blank? }

  has_many :countees
end
