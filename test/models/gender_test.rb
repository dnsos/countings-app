require "test_helper"

class GenderTest < ActiveSupport::TestCase
  test "should reject a gender without a label_de" do
    gender = Gender.new(label_de: "")
    gender.valid?
    assert_not gender.errors[:label_de].empty?
  end

  test "should reject a gender without a label_en" do
    gender = Gender.new(label_en: "")
    gender.valid?
    assert_not gender.errors[:label_en].empty?
  end

  test "should accept a gender with valid attributes" do
    gender = Gender.new(label_de: "Ein Label", label_en: "A label")
    gender.valid?
    assert_empty gender.errors[:label_en]
    assert_empty gender.errors[:label_de]
  end
end
