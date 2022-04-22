require 'test_helper'

# The AgeGroupTest tests validations for the AgeGroup model:
class AgeGroupTest < ActiveSupport::TestCase
  test 'should reject an age group without a min_age' do
    age_group = AgeGroup.new(min_age: nil)
    age_group.valid?
    assert_not age_group.errors[:min_age].empty?
  end

  test 'should reject an age group with a min_age higher than the max_age' do
    age_group = AgeGroup.new(min_age: 50, max_age: 49)
    age_group.valid?
    assert_not age_group.errors[:max_age].empty?
  end

  test 'should accept an age group with valid attributes' do
    age_group = AgeGroup.new(min_age: 40, max_age: 50)
    age_group.valid?
    assert_empty age_group.errors[:max_age]
  end

  test 'label combines min age and max age' do
    age_group = AgeGroup.new(min_age: 20, max_age: 30)
    age_group.valid?
    assert_equal age_group.label, '20 - 30'
  end

  test 'label displays value+ if no max_age is given' do
    age_group = AgeGroup.new(min_age: 90)
    age_group.valid?
    assert_equal age_group.label, '90+'
  end
end
