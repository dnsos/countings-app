require 'test_helper'

class CounteesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @counting = countings(:ongoing)
    @countee = countees(:with_all_attributes)
    @locale = :en
  end

  test 'should get index' do
    get counting_countees_url(@counting, { locale: @locale })

    assert_response :success
  end

  test 'should get new' do
    get new_counting_countee_url(@counting, { locale: @locale })

    assert_response :success
  end

  test 'should not get new as a signed-out user' do
    sign_out users(:admin)

    get new_counting_countee_url(@counting, { locale: @locale })

    assert_redirected_to new_user_session_url locale: @locale
  end

  test 'should create countee with valid params' do
    assert_difference('Countee.count') do
      post counting_countees_url(@counting, { locale: @locale }),
           params: {
             countee: {
               counting_id: @countee.counting.id,
               # Geolocation is within district fixture 'mitte':
               latitude: 52.522422,
               longitude: 13.391679,
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
      post counting_countees_url(@counting, { locale: @locale }),
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
      post counting_countees_url(@counting, { locale: @locale }),
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

  test 'should show countee' do
    get counting_countee_url(@counting, @countee, { locale: @locale })
    assert_response :success
  end

  test 'should get edit' do
    get edit_counting_countee_url(@counting, @countee, { locale: @locale })
    assert_response :success
  end

  test 'should not get edit as a non-admin user' do
    sign_in users(:regular)

    get edit_counting_countee_url(@counting, @countee, { locale: @locale })

    assert_response :not_found
    assert_equal flash[:alert], I18n.t('errors.messages.not_authorized')
  end

  test 'should not get edit as a signed-out user' do
    sign_out users(:admin)

    get edit_counting_countee_url(@counting, @countee, { locale: @locale })

    assert_redirected_to new_user_session_url locale: @locale
  end

  test 'should update countee' do
    patch counting_countee_url(@counting, @countee, { locale: @locale }),
          params: {
            countee: {
              age_group_id: @countee.age_group_id,
              gender_id: @countee.gender_id,
              pet_count: @countee.pet_count + 1,
            },
          }
    assert_redirected_to counting_countee_url(
                           @counting,
                           @countee,
                           { locale: @locale },
                         )
  end

  test 'should update countee to one where some data becomes null' do
    patch counting_countee_url(@counting, @countee, { locale: @locale }),
          params: {
            countee: {
              age_group_id: nil,
              gender_id: nil,
              pet_count: @countee.pet_count,
            },
          }
    assert_redirected_to counting_countee_url(
                           @counting,
                           @countee,
                           { locale: @locale },
                         )

    updated_countee = Countee.find(@countee.id)

    assert_nil updated_countee.gender_id
    assert_nil updated_countee.age_group_id
    assert_equal updated_countee.pet_count, @countee.pet_count
  end

  test 'should not update countee due to invalid pet count' do
    patch counting_countee_url(@counting, @countee, { locale: @locale }),
          params: {
            countee: {
              age_group_id: @countee.age_group_id,
              gender_id: @countee.gender_id,
              pet_count: -1,
            },
          }

    assert_response :unprocessable_entity
  end

  test 'should delete countee' do
    assert_difference('Countee.count', -1) do
      delete counting_countee_url(@counting, @countee, { locale: @locale })
    end

    assert_redirected_to counting_countees_url(@counting, { locale: @locale })
  end

  test 'should not delete countee as a non-admin user' do
    sign_in users(:regular)

    assert_no_difference('Countee.count') do
      delete counting_countee_url(@counting, @countee, { locale: @locale })
    end

    assert_response :not_found
    assert_equal flash[:alert], I18n.t('errors.messages.not_authorized')
  end

  test 'should not delete countee as a signed-out user' do
    sign_out users(:admin)

    assert_no_difference('Countee.count') do
      delete counting_countee_url(@counting, @countee, { locale: @locale })
    end

    assert_redirected_to new_user_session_url locale: @locale
  end
end
