require_relative 'countee/validator/created_at_validator'
require_relative 'countee/validator/age_group_validator'
require_relative 'countee/validator/district_validator'
require_relative 'countee/validator/gender_validator'

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

  validates :latitude, :longitude, presence: true, on: :create
  validates :latitude,
            numericality: {
              greater_than_or_equal_to: -90,
              smaller_than_or_equal_to: 90,
            },
            on: :create
  validates :longitude,
            numericality: {
              greater_than_or_equal_to: -180,
              smaller_than_or_equal_to: 180,
            },
            on: :create

  validates_with DistrictValidator, on: :create

  validates_with AgeGroupValidator

  validates_with GenderValidator
end
