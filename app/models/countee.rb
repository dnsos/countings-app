class Countee < ApplicationRecord
  belongs_to :counting
  belongs_to :counting_area

  belongs_to :gender, optional: true
  belongs_to :age_group, optional: true

  validate :created_while_counting_ongoing, on: :create

  validates :pet_count,
    numericality: {
      greater_than_or_equal_to: 0
    },
    allow_nil: true

  validates :gender_id, inclusion: {
    in: Gender.pluck(:id), message:  I18n.t("activerecord.errors.models.countee.attributes.gender_id.invalid")
  }, allow_blank: true

  validates :age_group_id, inclusion: {
    in: AgeGroup.pluck(:id), message:  I18n.t("activerecord.errors.models.countee.attributes.age_group_id.invalid")
  }, allow_blank: true

  private

  def created_while_counting_ongoing
    unless counting.ongoing?
      errors.add :base, :counting_not_ongoing, message:
        I18n.t(
          "activerecord.errors.models.countee.base.counting_not_ongoing"
        )
    end
  end
end
