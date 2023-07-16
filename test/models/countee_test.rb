require "test_helper"

class CounteeTest < ActiveSupport::TestCase
  test "should not be able to create countee for a concluded counting" do
    countee = Countee.new(counting: countings(:concluded))
    countee.valid?
    assert countee.errors.any?
  end

  test "should be able to create countee during ongoing counting" do
    countee = Countee.new(counting: countings(:ongoing))
    countee.valid?
    assert_empty countee.errors[:created_at]
  end

  test "should be able to create countee without all unnecessary attributes" do
    countee = countees(:without_all_unnecessary_attributes)
    countee.valid?
    assert_empty countee.errors
  end

  test "should be able to create countee with partial unnecessary attributes" do
    countee = countees(:with_partial_unnecessary_attributes)
    countee.valid?
    assert_empty countee.errors
  end

  test "should be able to create countee with all attributes" do
    countee = countees(:with_all_attributes)
    countee.valid?
    assert_empty countee.errors
  end
end
