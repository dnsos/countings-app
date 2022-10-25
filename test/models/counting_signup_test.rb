require 'test_helper'

class CountingSignupTest < ActiveSupport::TestCase
  test 'should reject a signup if user is already signed up for the counting' do
    # Invalid counting signup because users(:regular) has already signed up via the fixtures:
    counting_signup =
      CountingSignup.new(counting: countings(:future), user: users(:regular))

    counting_signup.valid?
    assert_not counting_signup.errors[:user].empty?,
               'Expected counting signup to error because [:counting, :user] uniqueness validation was violated'
  end

  test 'should reject a signup that is outside of the time period for signup' do
    counting = countings(:future)
    date_after_signup_period_ended = counting.starts_at - 1.day

    travel_to date_after_signup_period_ended do
      counting_signup =
        CountingSignup.new(counting: counting, user: users(:alice))

      counting_signup.valid?
      assert_not counting_signup.errors[:created_at].empty?,
                 'Expected counting signup to be invalid because signup period has ended'
    end
  end

  test 'should accept signup for an ongoing counting with an existing user' do
    # users(:alice) is not signed up in the test fixtures:
    counting_signup =
      CountingSignup.new(counting: countings(:future), user: users(:alice))

    counting_signup.valid?
    assert_empty counting_signup.errors, 'Expected errors to be empty'
  end
end
