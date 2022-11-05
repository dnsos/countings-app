class CountingSignup < ApplicationRecord
  belongs_to :counting
  belongs_to :user

  validates :user, uniqueness: { scope: :counting }
end
