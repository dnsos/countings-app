require "application_system_test_case"

class AreaAssignmentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:ongoing)
    @signed_up_user = users(:regular)
    @area_assignment = area_assignments(:regular_user_ongoing_counting_one)
    I18n.locale = :de
  end

  test "displays all area assignments to user" do
    sign_in @signed_up_user
    visit user_counting_area_assignments_url(@counting, locale: I18n.locale)
  end

  test "creates area assignment after first failing to provide params" do
    sign_in users(:admin)

    visit new_counting_area_assignment_url(@counting, locale: I18n.locale)

    click_on I18n.t("helpers.submit.area_assignment.create")

    assert_text I18n.t("errors.messages.blank"), count: 2

    select(
      counting_areas(:mitte_two).name,
      from: I18n.t("activerecord.attributes.area_assignment.counting_area_id")
    )

    select(
      counting_signups(:two).user.email,
      from:
        I18n.t("activerecord.attributes.area_assignment.counting_signup_id")
    )

    click_on I18n.t("helpers.submit.area_assignment.create")

    assert_text I18n.t("area_assignments.create.notice")
  end

  test "updates area assignment" do
    sign_in users(:admin)

    visit edit_counting_area_assignment_url(
      @counting,
      @area_assignment,
      locale: I18n.locale
    )

    select(
      counting_signups(:three).user.email,
      from:
        I18n.t("activerecord.attributes.area_assignment.counting_signup_id")
    )

    click_on I18n.t("helpers.submit.area_assignment.update")

    assert_text I18n.t("area_assignments.update.notice")
  end
end
