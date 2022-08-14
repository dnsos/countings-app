# Ensures age group exists (or is empty):
class AgeGroupValidator < ActiveModel::Validator
  def validate(countee)
    unless countee.age_group_id.blank? || AgeGroup.exists?(countee.age_group_id)
      countee.errors.add :age_group_id,
                         I18n.t(
                           'activerecord.errors.models.countee.attributes.age_group_id.invalid',
                         )
    end
  end
end

# This is a custom validator that ensures that a countee can only be added while the associated counting is ongoing.
class CreatedAtValidator < ActiveModel::Validator
  def validate(countee)
    unless countee.counting.ongoing?
      countee.errors.add :created_at,
                         I18n.t(
                           'activerecord.errors.models.countee.attributes.created_at',
                         )
    end
  end
end

# This is a custom validator that ensures that the latitude and longitude of a countee find the associated district.
class DistrictValidator < ActiveModel::Validator
  def validate(countee)
    has_latitude_longitude =
      countee.latitude.present? && countee.longitude.present?

    containing_districts =
      District.contains_point?(countee.latitude.to_f, countee.longitude.to_f)

    unless has_latitude_longitude
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :no_lat_lon,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.no_lat_lon',
                           )
    end

    if has_latitude_longitude && containing_districts.empty?
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :none_found,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.none_found',
                           )
    end

    if has_latitude_longitude && containing_districts.length > 1
      # First, clear out the default error for a non-existent, required association:
      countee.errors.delete(:district)

      # Instead, get more precise:
      countee.errors.add :district,
                         :not_one,
                         message:
                           I18n.t(
                             'activerecord.errors.models.countee.attributes.district.not_one',
                           )
    end
  end
end

# Ensures gender exists (or is empty):
class GenderValidator < ActiveModel::Validator
  def validate(countee)
    unless countee.gender_id.blank? || Gender.exists?(countee.gender_id)
      countee.errors.add :gender_id,
                         I18n.t(
                           'activerecord.errors.models.countee.attributes.gender_id.invalid',
                         )
    end
  end
end

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
