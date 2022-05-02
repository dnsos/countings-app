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
end
