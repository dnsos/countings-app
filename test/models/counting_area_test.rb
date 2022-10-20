require 'test_helper'

class CountingAreaTest < ActiveSupport::TestCase
  test 'should reject a counting area without a geometry' do
    counting_area = CountingArea.new(geometry: nil)
    counting_area.valid?
    assert_not counting_area.errors[:geometry].empty?
  end

  test 'should accept a counting area with valid attributes' do
    counting_area =
      CountingArea.new(
        name: 'Mitte 2', # This is a nullable field and could be left out
        geometry:
          'MULTIPOLYGON (((13.386680 52.525310, 13.387264 52.520037, 13.407143 52.520708, 13.405245 52.525406)))',
      )
    counting_area.valid?
    assert_empty counting_area.errors[:name]
    assert_empty counting_area.errors[:geometry]
  end
end
