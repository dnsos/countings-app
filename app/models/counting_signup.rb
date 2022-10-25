class CountingSignup < ApplicationRecord
  belongs_to :counting
  belongs_to :user

  validates :user,
            uniqueness: {
              scope: :counting,
              message: 'A user may only signup for a counting once',
            }

  validate :within_signup_period?

  private

  MIN_TIME_BEFORE_COUNTING = 7.days

  def within_signup_period?
    unless Time.now.before? counting.starts_at - MIN_TIME_BEFORE_COUNTING
      errors.add(:created_at, 'is not within signup period')
    end
  end
end
