class Countee < ApplicationRecord
  belongs_to :counting
  belongs_to :counting_area

  belongs_to :gender, optional: true
  belongs_to :age_group, optional: true

  validate :created_while_counting_ongoing,
           :gender_is_blank_or_exists,
           :age_group_is_blank_or_exists

  validates :pet_count,
            numericality: {
              greater_than_or_equal_to: 0
            },
            unless: -> { pet_count.blank? }

  private

  def created_while_counting_ongoing
    unless self.counting.ongoing?
      self.errors.add :created_at,
                      I18n.t(
                        "activerecord.errors.models.countee.attributes.created_at"
                      )
    end
  end

  def gender_is_blank_or_exists
    unless self.gender_id.blank? || Gender.exists?(self.gender_id)
      self.errors.add :gender_id,
                      I18n.t(
                        "activerecord.errors.models.countee.attributes.gender_id.invalid"
                      )
    end
  end

  def age_group_is_blank_or_exists
    unless self.age_group_id.blank? || AgeGroup.exists?(self.age_group_id)
      self.errors.add :age_group_id,
                      I18n.t(
                        "activerecord.errors.models.countee.attributes.age_group_id.invalid"
                      )
    end
  end
end
