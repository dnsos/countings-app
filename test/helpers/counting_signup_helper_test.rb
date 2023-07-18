require "test_helper"

class CountingSignupHelperTest < ActionView::TestCase
  test "displays a label with user email and areas count" do
    counting_signup = counting_signups(:one)

    # TODO: do it
    assert_includes user_email_and_area_assignments_count(counting_signup.user, counting_signup.area_assignments), "20 – 30"
  end
end
