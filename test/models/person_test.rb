require 'test_helper'

# PersonTest
class PersonTest < ActiveSupport::TestCase
  test 'should reject a person with an invalid pet count' do
    person = Person.new(pet_count: -1)
    person.valid?
    assert_not person.errors[:pet_count].empty?
  end

  test 'should accept a person with a valid pet count' do
    person = Person.new(pet_count: 1)
    person.valid?
    assert_empty person.errors[:pet_count]
  end
end
