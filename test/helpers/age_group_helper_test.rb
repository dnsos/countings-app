require "test_helper"

class AgeGroupHelperTest < ActionView::TestCase
  test "displays an age group label with min age and max age" do
    age_group = AgeGroup.new(min_age: 20, max_age: 30)

    assert_equal age_group_label(age_group.min_age, age_group.max_age), "20 – 30"
  end

  test "displays an age group label for a group that has no max age" do
    age_group = AgeGroup.new(min_age: 65)

    assert_equal age_group_label(age_group.min_age, age_group.max_age), "65+"
  end

  test "returns all age groups with their label elements" do
    age_groups = [age_groups(:one), age_groups(:two)]

    age_groups_with_label(age_groups).each do |age_group|
      assert age_group.label
    end
  end
end
