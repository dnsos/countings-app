require 'application_system_test_case'

# DistrictEncounters system test
class DistrictEncountersTest < ApplicationSystemTestCase
  setup do
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'view district encounters belonging to a counting' do
    visit counting_url(@counting, locale: @locale)

    click_on I18n.t('district_encounters.index.title')
    assert_selector '#map-root'
  end
end
