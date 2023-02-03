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
  belongs_to :counting_area

  belongs_to :gender, optional: true
  belongs_to :age_group, optional: true

  validates_with CreatedAtValidator

  validates :pet_count,
            numericality: {
              greater_than_or_equal_to: 0,
            },
            unless: -> { pet_count.blank? }

  validates_with AgeGroupValidator

  validates_with GenderValidator
end
