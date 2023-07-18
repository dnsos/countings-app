require "test_helper"

# The CountingTest tests validations for the Counting model:
class CountingTest < ActiveSupport::TestCase
  test "should reject a counting without a title" do
    counting = Counting.new(title: "")
    counting.valid?
    assert_not counting.errors[:title].empty?
  end

  test "should reject a counting without a start date" do
    counting = Counting.new(starts_at: "")
    counting.valid?
    assert_not counting.errors[:starts_at].empty?
  end

  test "should reject a counting without an end date" do
    counting = Counting.new(ends_at: "")
    counting.valid?
    assert_not counting.errors[:ends_at].empty?
  end

  test "should reject a counting with an end date the is before the start date" do
    counting = Counting.new(starts_at: Time.now, ends_at: Time.now - 2.days)
    counting.valid?
    assert_not counting.errors[:ends_at].empty?
  end

  test "should accept a counting with valid attributes" do
    counting =
      Counting.new(
        title: "I am a title",
        starts_at: Time.now,
        ends_at: Time.now + 2.days
      )
    counting.valid?
    assert_empty counting.errors[:title]
    assert_empty counting.errors[:starts_at]
    assert_empty counting.errors[:ends_at]
  end

  test "informs about its ongoing status" do
    counting =
      Counting.new(
        title: "I am a title",
        starts_at: Time.now - 1.day,
        ends_at: Time.now + 2.days
      )
    assert counting.ongoing?
  end

  test "informs about its signup period" do
    counting =
      Counting.new(
        title: "I am a title",
        starts_at: Time.now + 14.days,
        ends_at: Time.now + 15.days
      )
    assert counting.signups_allowed?
  end

  test "informs about its area assignment period" do
    counting =
      Counting.new(
        title: "I am a title",
        starts_at: Time.now + 3.days,
        ends_at: Time.now + 4.days
      )
    assert counting.area_assignments_allowed?
  end
end
