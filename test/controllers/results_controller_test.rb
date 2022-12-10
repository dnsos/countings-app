require 'test_helper'

class ResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @counting = countings(:ongoing)
    I18n.locale = :en
  end

  test 'gets counting_area results' do
    get counting_counting_area_results_url(
          @counting,
          { locale: I18n.locale, format: :json },
        )
    assert_response :success
  end

  test 'gets gender results' do
    get counting_gender_results_url(
          @counting,
          { locale: I18n.locale, format: :json },
        )
    assert_response :success
  end

  test 'gets age group results' do
    get counting_age_group_results_url(
          @counting,
          { locale: I18n.locale, format: :json },
        )
    assert_response :success
  end
end
