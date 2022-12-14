require 'test_helper'

class AreaAssignmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:ongoing)

    # This user is signed up for the ongoing counting:
    @signed_up_user = users(:regular)

    # The user has been asiggned to this area:
    @area_assignment = area_assignments(:regular_user_ongoing_counting_one)

    I18n.locale = :de

    @new_area_assignment_params = {
      area_assignment: {
        # mitte_two has not been assigned to a signup in the fixtures:
        counting_area_id: counting_areas(:mitte_two).id,
        # signup two is for same counting as mitte_two counting area:
        counting_signup_id: counting_signups(:two).id,
      },
    }
  end

  test 'should get user\'s area assignments page' do
    sign_in @signed_up_user

    get user_counting_area_assignments_url(@counting, locale: I18n.locale)
    assert_response :success
  end

  test 'should get user\'s area assignments page with specific first area assignment' do
    sign_in @signed_up_user

    get user_counting_area_assignments_url(
          @counting,
          counting_area_id: @area_assignment.counting_area_id,
          locale: I18n.locale,
        )
    assert_response :success
  end

  test 'non-admin can not reach new page' do
    sign_in users(:regular)

    get new_counting_area_assignment_path(@counting, locale: I18n.locale)

    assert_response :not_found
  end

  test 'admin can reach new page' do
    sign_in users(:admin)

    get new_counting_area_assignment_path(@counting, locale: I18n.locale)

    assert_response :success
  end

  test 'non-admin can not create area assignment' do
    sign_in users(:regular)

    assert_no_difference('AreaAssignment.count') do
      post counting_area_assignments_url(@counting, { locale: I18n.locale }),
           params: @new_area_assignment_params
    end
  end

  test 'admin can create area assignment' do
    sign_in users(:admin)

    assert_difference('AreaAssignment.count') do
      post counting_area_assignments_url(@counting, { locale: I18n.locale }),
           params: @new_area_assignment_params
    end

    assert_redirected_to edit_counting_area_assignment_url(
                           @counting,
                           AreaAssignment.last,
                         )
  end

  test 'admin can not create area assignment with invalid params' do
    assert_no_difference('AreaAssignment.count') do
      post counting_area_assignments_url(@counting, { locale: I18n.locale }),
           # We merge in an invalid counting_area_id to check whether it gets accepted:
           params: @new_area_assignment_params.merge(counting_area_id: nil)
    end
  end

  test 'non-admin can not get edit page' do
    sign_in users(:regular)

    get edit_counting_area_assignment_url(
          @counting,
          @area_assignment,
          { locale: I18n.locale },
        )

    assert_response :not_found
  end

  test 'admin can get edit page' do
    sign_in users(:admin)

    get edit_counting_area_assignment_url(
          @counting,
          @area_assignment,
          { locale: I18n.locale },
        )

    assert_response :success
  end

  test 'non-admin can not update area assignment' do
    sign_in users(:regular)

    patch counting_area_assignment_url(
            @counting,
            @area_assignment,
            { locale: I18n.locale },
          ),
          params: {
            area_assignment: {
              # signup three is also a signup for the current ongoing counting:
              counting_signup_id: counting_signups(:three).id,
            },
          }
    assert_response :not_found
  end

  test 'admin can update area assignment' do
    sign_in users(:admin)

    patch counting_area_assignment_url(
            @counting,
            @area_assignment,
            { locale: I18n.locale },
          ),
          params: {
            area_assignment: {
              # signup three is also a signup for the current ongoing counting:
              counting_signup_id: counting_signups(:three).id,
            },
          }
    assert_redirected_to edit_counting_area_assignment_url(
                           @counting,
                           @area_assignment,
                         )
  end

  test 'non-admin can not destroy area assignment' do
    sign_in users(:regular)

    assert_no_difference('AreaAssignment.count') do
      delete counting_area_assignment_url(
               @counting,
               @area_assignment,
               locale: I18n.locale,
             )
    end

    assert_response :not_found
  end

  test 'admin can destroy area assignment' do
    sign_in users(:admin)

    assert_difference('AreaAssignment.count', -1) do
      delete counting_area_assignment_url(
               @counting,
               @area_assignment,
               locale: I18n.locale,
             )
    end

    assert_redirected_to new_counting_area_assignment_url(@counting)
  end
end
