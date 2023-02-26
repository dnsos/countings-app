require "test_helper"

class AreaAssignmentTest < ActiveSupport::TestCase
  test "should accept area assigment for counting area that is not yet assigned" do
    area_assignment =
      AreaAssignment.new(
        counting_signup: counting_signups(:five),
        # This area has not yet been assigned in the fixtures:
        counting_area: counting_areas(:lichtenberg_1_future)
      )

    area_assignment.valid?
    assert_empty area_assignment.errors, "Expected errors to be empty"
  end

  test "should prevent duplicate area assigment" do
    area_assignment =
      AreaAssignment.new(
        counting_signup: counting_signups(:six),
        # Fixtures have already assigned the following area to a signup:
        counting_area: counting_areas(:mitte_1_future)
      )

    area_assignment.valid?
    assert_not area_assignment.errors.empty?,
      "Expected errors to exist because of duplicate area assignment"
  end
end
