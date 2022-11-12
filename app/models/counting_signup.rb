class CountingSignup < ApplicationRecord
  belongs_to :counting
  belongs_to :user

  has_many :area_assignments

  validates :user,
            uniqueness: {
              scope: :counting,
              message:
                I18n.t(
                  'activerecord.errors.models.counting_signup.attributes.user.uniqueness',
                ),
            }
end
