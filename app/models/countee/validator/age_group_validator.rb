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
