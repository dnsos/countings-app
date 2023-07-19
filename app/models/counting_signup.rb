class CountingSignup < ApplicationRecord
  belongs_to :counting
  belongs_to :user

  has_many :area_assignments, dependent: :destroy

  validates :user,
    uniqueness: {
      scope: :counting,
      message:
        I18n.t(
          "activerecord.errors.models.counting_signup.attributes.user.uniqueness"
        )
    }

  validate :signup_allowed

  def signup_allowed
    unless counting.signups_allowed?
      errors.add :base, I18n.t(
        "activerecord.errors.models.counting_signup.attributes.base.signups_disallowed"
      )
    end
  end

  def user_email_and_area_count
    "#{user.email} (#{area_assignments.count} #{I18n.t("activerecord.models.area_assignment.other")})"
  end
end
