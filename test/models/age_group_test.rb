require "test_helper"

class AgeGroupTest < ActiveSupport::TestCase
  test "should reject an age group without a min_age" do
    age_group = AgeGroup.new(min_age: nil)
    age_group.valid?
    assert_not age_group.errors[:min_age].empty?
  end

  test "should reject an age group with a min_age higher than the max_age" do
    age_group = AgeGroup.new(min_age: 50, max_age: 49)
    age_group.valid?
    assert_not age_group.errors[:max_age].empty?
  end

  test "should accept an age group with valid attributes" do
    age_group = AgeGroup.new(min_age: 40, max_age: 50)
    age_group.valid?
    assert_empty age_group.errors[:max_age]
  end

  test "should accept an age group with only a min_age" do
    age_group = AgeGroup.new(min_age: 90)
    age_group.valid?
    assert_empty age_group.errors[:min_age]
  end
end
