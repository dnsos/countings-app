require 'application_system_test_case'

class AreaAssignmentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:ongoing)
    @signed_up_user = users(:regular)
    @area_assignment = area_assignments(:regular_user_ongoing_counting_one)
    I18n.locale = :de
  end

  test 'displays all area assignments to user' do
    sign_in @signed_up_user
    visit user_counting_area_assignments_url(@counting, locale: I18n.locale)
  end
end
