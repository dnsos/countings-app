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
  end

  test 'should get user\'s area assignments page' do
    sign_in @signed_up_user

    get counting_area_assignments_user_url(@counting, locale: I18n.locale)
    assert_response :success
  end

  test 'should get user\'s area assignments page with specific first area assignment' do
    sign_in @signed_up_user

    get counting_area_assignments_user_url(
          @counting,
          counting_area_id: @area_assignment.counting_area_id,
          locale: I18n.locale,
        )
    assert_response :success
  end
end
