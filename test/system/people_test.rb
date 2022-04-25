require 'application_system_test_case'

# People system test
class PeopleTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'edit a counted person' do
    visit counting_url(@counting, locale: @locale)
    assert_text I18n.t('common.admin_area')

    click_on I18n.t('people.index.title')
    assert_selector 'h1', text: I18n.t('people.index.title')

    click_on I18n.t('people.edit.title'), match: :first
    select AgeGroup.last.label,
           from: I18n.t('activerecord.attributes.person.age_group_id')

    # We can test for this because all fixtures have an AgeGroup that is not the last
    assert_text AgeGroup.last.label
  end
end
