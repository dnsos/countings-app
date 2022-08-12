require 'application_system_test_case'

class CounteesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:ongoing)
    @countee = countees(:with_all_attributes)
    I18n.locale = :de
  end

  test 'displays all countees to admin user' do
    sign_in users(:admin)
    visit counting_countees_url(@counting, locale: I18n.locale)
    assert_selector 'h1', text: I18n.t('countees.index.title')
  end

  test 'creates countee' do
    sign_in users(:regular)
    visit counting_url(@counting, locale: I18n.locale)

    click_on I18n.t('countees.new.title')

    find_field('Latitude', visible: :all).set(52.522422)
    find_field('Longitude', visible: :all).set(13.391679)

    click_on I18n.t(
               'helpers.submit.create',
               model: I18n.t('activerecord.models.countee.one').to_s,
             )

    assert_text I18n.t('countees.create.notice')
  end

  test 'creates countee after first failing to provide geolocation' do
    sign_in users(:regular)
    visit counting_url(@counting, locale: I18n.locale)

    click_on I18n.t('countees.new.title')

    click_on I18n.t(
               'helpers.submit.create',
               model: I18n.t('activerecord.models.countee.one').to_s,
             )

    assert_text I18n.t('common.error')

    find_field('Latitude', visible: :all).set(52.522422)
    find_field('Longitude', visible: :all).set(13.391679)

    click_on I18n.t(
               'helpers.submit.create',
               model: I18n.t('activerecord.models.countee.one').to_s,
             )

    assert_text I18n.t('countees.create.notice')
  end

  test 'creates countee after first failing to provide valid pet count' do
    sign_in users(:regular)
    visit counting_url(@counting, locale: I18n.locale)

    click_on I18n.t('countees.new.title')

    # Ideally, we should test clicking the canvas-based map for the geoposition.
    # However, I am not quite sure how we can ensure that the clicked point
    # lies within one of the fixture districts:
    # We'd need something like this:
    # find('#map').click(x: 10, y: 10)
    #
    # Instead we programmatically fill the inputs.
    # The following latitude/longitude are within one of the fixture districts:
    find_field('Latitude', visible: :all).set(52.522422)
    find_field('Longitude', visible: :all).set(13.391679)

    fill_in I18n.t('activerecord.attributes.countee.pet_count'), with: -1

    click_on I18n.t(
               'helpers.submit.create',
               model: I18n.t('activerecord.models.countee.one').to_s,
             )

    assert_text I18n.t('common.error')

    find('[aria-label="Map marker"]')

    fill_in I18n.t('activerecord.attributes.countee.pet_count'), with: 1

    click_on I18n.t(
               'helpers.submit.create',
               model: I18n.t('activerecord.models.countee.one').to_s,
             )

    assert_text I18n.t('countees.create.notice')
  end

  test 'deletes Countee' do
    sign_in users(:admin)

    visit counting_countees_url(@counting, locale: I18n.locale)
    click_on I18n.t('countees.destroy.title'), match: :first

    accept_alert

    assert_text I18n.t('countees.destroy.notice')
  end
end
