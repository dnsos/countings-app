require 'application_system_test_case'

class CounteesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @countee = countees(:with_all_attributes)
    @locale = 'de'
  end

  test 'displays all countees to admin user' do
    visit countees_url
    assert_selector 'h1', text: 'Countees'
  end

  test 'creates countee' do
    visit countees_url
    click_on 'New countee'

    fill_in 'Age group', with: @countee.age_group_id
    fill_in 'Counting', with: @countee.counting_id
    fill_in 'District', with: @countee.district_id
    fill_in 'Gender', with: @countee.gender_id
    fill_in 'Pet count', with: @countee.pet_count
    click_on 'Create Countee'

    assert_text 'Countee was successfully created'
    click_on 'Back'
  end

  test 'creates countee after first failing to provide geolocation' do
    visit countees_url
    click_on 'New countee'

    fill_in 'Age group', with: @countee.age_group_id
    fill_in 'Counting', with: @countee.counting_id
    fill_in 'District', with: @countee.district_id
    fill_in 'Gender', with: @countee.gender_id
    fill_in 'Pet count', with: @countee.pet_count
    click_on 'Create Countee'

    assert_text 'Countee was successfully created'
    click_on 'Back'
  end

  test 'creates countee after first failing to provide valid pet count' do
    visit countees_url
    click_on 'New countee'

    fill_in 'Age group', with: @countee.age_group_id
    fill_in 'Counting', with: @countee.counting_id
    fill_in 'District', with: @countee.district_id
    fill_in 'Gender', with: @countee.gender_id
    fill_in 'Pet count', with: @countee.pet_count
    click_on 'Create Countee'

    assert_text 'Countee was successfully created'
    click_on 'Back'
  end

  test 'deletes Countee' do
    sign_in users(:admin)

    visit counting_countees_url(@countee.counting, locale: @locale)
    click_on I18n.t('countees.destroy.title'), match: :first

    accept_alert

    assert_text I18n.t('countees.destroy.notice')
  end
end
