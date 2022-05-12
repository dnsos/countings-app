require 'application_system_test_case'

# Geolocations system test
class GeolocationsTest < ApplicationSystemTestCase
  setup do
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'view geolocations belonging to a counting' do
    visit counting_url(@counting, locale: @locale)

    click_on I18n.t('geolocations.index.title')
    assert_selector '#map-root'
  end
end
