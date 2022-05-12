require 'test_helper'

# DistrictTest
class DistrictTest < ActiveSupport::TestCase
  test 'should reject a district without a name' do
    district = District.new(name: nil)
    district.valid?
    assert_not district.errors[:name].empty?
  end

  test 'should reject a district without a geometry' do
    district = District.new(geometry: nil)
    district.valid?
    assert_not district.errors[:geometry].empty?
  end

  test 'should accept a district with valid attributes' do
    district =
      District.new(
        name: 'Some name',
        geometry:
          'MULTIPOLYGON (((13.386680 52.525310, 13.387264 52.520037, 13.407143 52.520708, 13.405245 52.525406)))',
      )
    district.valid?
    assert_empty district.errors[:name]
    assert_empty district.errors[:geometry]
  end
end
