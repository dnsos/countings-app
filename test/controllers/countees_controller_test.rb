require 'test_helper'
require 'csv'

class CounteesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @counting = countings(:ongoing)
    @countee = countees(:with_all_attributes)
    I18n.locale = :de
  end

  test 'should get index' do
    get counting_countees_url(@counting, { locale: I18n.locale })

    assert_response :success
  end

  test 'should download all countees as CSV' do
    get all_counting_countees_url(
          @counting,
          { locale: I18n.locale, format: :csv },
        )

    assert_equal response.content_type, 'text/csv'

    # We use the parsed CSV for checking if there are as many rows
    # as there are fixture countees.
    # If we wanted to improve this test even more,
    # we could additionally check the contents of each row to see
    # if it matches the fixture data entries.
    parsed_csv =
      CSV.parse(response.parsed_body, headers: true, skip_blanks: true)

    assert_equal parsed_csv.length, @counting.countees.length

    assert_response :success
  end

  test 'should get new' do
    get new_counting_countee_url(@counting, { locale: I18n.locale })

    assert_response :success
  end

  test 'should not get new as a signed-out user' do
    sign_out users(:admin)

    get new_counting_countee_url(@counting, { locale: I18n.locale })

    assert_redirected_to new_user_session_url locale: I18n.locale
  end

  test 'should create countee with valid params' do
    assert_difference('Countee.count') do
      post counting_countees_url(@counting, { locale: I18n.locale }),
           params: {
             countee: {
               counting_id: @countee.counting.id,
               counting_area_id: @countee.counting_area.id,
               age_group_id: @countee.age_group.id,
               gender_id: @countee.gender.id,
               pet_count: @countee.pet_count,
             },
           }
    end

    assert_redirected_to new_counting_countee_url
  end

  test 'should not create countee with invalid geolocation' do
    assert_no_difference('Countee.count') do
      post counting_countees_url(@counting, { locale: I18n.locale }),
           params: {
             countee: {
               counting_id: @countee.counting.id,
               # Geolocation is somewhere outside of Berlin:
               latitude: 59.522422,
               longitude: 19.391679,
               age_group_id: @countee.age_group.id,
               gender_id: @countee.gender.id,
               pet_count: @countee.pet_count,
             },
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should not create countee with missing geolocation' do
    assert_no_difference('Countee.count') do
      post counting_countees_url(@counting, { locale: I18n.locale }),
           params: {
             countee: {
               counting_id: @countee.counting.id,
               latitude: nil,
               longitude: nil,
               age_group_id: @countee.age_group.id,
               gender_id: @countee.gender.id,
               pet_count: @countee.pet_count,
             },
           }
    end

    assert_response :unprocessable_entity
  end

  test 'should delete countee' do
    assert_difference('Countee.count', -1) do
      delete counting_countee_url(@counting, @countee, { locale: I18n.locale })
    end

    assert_redirected_to counting_countees_url(
                           @counting,
                           { locale: I18n.locale },
                         )
  end

  test 'should not delete countee as a non-admin user' do
    sign_in users(:regular)

    assert_no_difference('Countee.count') do
      delete counting_countee_url(@counting, @countee, { locale: I18n.locale })
    end

    assert_response :not_found
    assert_equal flash[:alert], I18n.t('errors.messages.not_authorized')
  end

  test 'should not delete countee as a signed-out user' do
    sign_out users(:admin)

    assert_no_difference('Countee.count') do
      delete counting_countee_url(@counting, @countee, { locale: I18n.locale })
    end

    assert_redirected_to new_user_session_url locale: I18n.locale
  end
end
