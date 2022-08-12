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
