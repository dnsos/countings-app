require 'application_system_test_case'

# Countings system test
class CountingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'visiting the index' do
    visit countings_url
    assert_selector 'h1', text: I18n.t('activerecord.models.counting.other')
  end

  test 'should create counting' do
    sign_in users(:alice) # Alice has role: admin

    visit countings_url
    click_on I18n.t('views.counting.new.title')

    fill_in I18n.t('activerecord.attributes.counting.description'), with: @counting.description
    fill_in I18n.t('activerecord.attributes.counting.ends_at'), with: @counting.ends_at
    fill_in I18n.t('activerecord.attributes.counting.starts_at'), with: @counting.starts_at
    fill_in I18n.t('activerecord.attributes.counting.title'), with: @counting.title
    click_on I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.counting.one').to_s)

    # assert_text 'Counting was successfully created' # TODO: when I have found out how to properly organize teh controller notice translations. Where do they belong?
    click_on I18n.t('views.counting.back.title')
  end

  test 'should update Counting' do
    sign_in users(:alice) # Alice has role: admin

    visit counting_url(@counting, locale: @locale)
    click_on I18n.t('views.counting.edit.title'), match: :first

    fill_in I18n.t('activerecord.attributes.counting.description'), with: @counting.description
    fill_in I18n.t('activerecord.attributes.counting.ends_at'), with: @counting.ends_at
    fill_in I18n.t('activerecord.attributes.counting.starts_at'), with: @counting.starts_at
    fill_in I18n.t('activerecord.attributes.counting.title'), with: @counting.title
    click_on I18n.t('helpers.submit.update', model: I18n.t('activerecord.models.counting.one').to_s)

    # assert_text 'Counting was successfully updated' # TODO: see above.
    click_on I18n.t('views.counting.back.title')
  end

  test 'should destroy Counting' do
    sign_in users(:alice) # Alice has role: admin

    visit counting_url(@counting, locale: @locale)
    click_on I18n.t('views.counting.destroy.title'), match: :first

    # assert_text 'Counting was successfully destroyed' # TODO: see above.
  end
end
