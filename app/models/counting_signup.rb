class CountingSignup < ApplicationRecord
  belongs_to :counting
  belongs_to :user

  has_many :area_assignments, dependent: :destroy

  validates :user,
            uniqueness: {
              scope: :counting,
              message:
                I18n.t(
                  'activerecord.errors.models.counting_signup.attributes.user.uniqueness',
                ),
            }

  def user_email
    user.email
  end
end
