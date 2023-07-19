require "test_helper"

class CountingSignupTest < ActiveSupport::TestCase
  test "should reject a signup if user is already signed up for the counting" do
    # Invalid counting signup because users(:regular) has already signed up via the fixtures:
    counting_signup =
      CountingSignup.new(counting: countings(:future), user: users(:regular))

    counting_signup.valid?
    assert_not counting_signup.errors[:user].empty?,
      "Expected counting signup to error because [:counting, :user] uniqueness validation was violated"
  end

  test "should accept signup for a future counting with an existing user" do
    # users(:alice) is not signed up in the test fixtures:
    counting_signup =
      CountingSignup.new(counting: countings(:future), user: users(:alice))

    counting_signup.valid?
    assert_empty counting_signup.errors, "Expected errors to be empty"
  end

  test "should reject signup when outside of allowed signup period" do
    counting_starting_tomorrow = countings(:starting_tomorrow)

    counting_signup = CountingSignup.new(counting: counting_starting_tomorrow)

    counting_signup.valid?
    assert counting_signup.errors[:base].present?, "Expected signup to be invalid because outside of allowed signup period"
  end
end
