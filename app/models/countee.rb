require_relative 'countee/validator'

class Countee < ApplicationRecord
  belongs_to :counting
  belongs_to :district

  belongs_to :gender, optional: true
  belongs_to :age_group, optional: true

  validates_with CreatedAtValidator

  validates :pet_count,
            numericality: {
              greater_than_or_equal_to: 0,
            },
            unless: -> { pet_count.blank? }

  attribute :latitude, :decimal
  attribute :longitude, :decimal

  validates_with DistrictValidator

  validates_with AgeGroupValidator

  validates_with GenderValidator
end
