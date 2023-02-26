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
end
