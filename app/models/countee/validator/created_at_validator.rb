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
