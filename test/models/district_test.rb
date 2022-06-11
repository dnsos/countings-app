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

  test 'should find a district when passed a point within its boundaries' do
    containing_districts = District.contains_point?(52.522422, 13.391679) # Point is Ebertsbrücke in Berlin
    assert_equal containing_districts.count,
                 1,
                 'Point can only be in one district at a time'

    assert_equal containing_districts.first.name,
                 districts(:mitte).name,
                 'Tested point lies within area of fixture Mitte district (Ebertsbrücke)'
  end

  test 'should not find a district with point outside Berlin' do
    containing_districts = District.contains_point?(52.400028, 13.067697) # Point is in Potsdam
    assert_empty containing_districts
  end

  test 'contains_point? raises error with invalid params' do
    assert_raises(ArgumentError) { District.contains_point?(nil, 'hello') }
  end
end
