require 'application_system_test_case'

# People system test
class PeopleTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'visiting the index' do
    visit counting_people_url(@counting, locale: @locale)
    assert_selector 'h1', text: I18n.t('views.person.index.title')
    # TODO: assert visible attributes of people
  end
end
