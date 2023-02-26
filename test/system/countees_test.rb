require "application_system_test_case"

class CounteesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:regular)
    @counting = countings(:ongoing)
    @countee = countees(:with_all_attributes)

    # This assignment has to match a counting_signup from the abovce @user:
    @first_area_assignment =
      area_assignments(:regular_user_ongoing_counting_one)
    I18n.locale = :de
  end

  test "displays all countees to admin user" do
    sign_in users(:admin)
    visit counting_countees_url(@counting, locale: I18n.locale)
    assert_selector "h1", text: I18n.t("countees.index.title")
  end

  test "creates countee" do
    sign_in @user
    visit counting_url(@counting, locale: I18n.locale)

    click_on I18n.t("countees.new.title")

    assert_text @first_area_assignment.counting_area.name

    click_on I18n.t(
      "helpers.submit.create",
      model: I18n.t("activerecord.models.countee.one").to_s
    )

    assert_text I18n.t("countees.create.notice")
  end

  test "creates countee after first failing to provide valid pet count" do
    sign_in users(:regular)
    visit counting_url(@counting, locale: I18n.locale)

    click_on I18n.t("countees.new.title")

    fill_in I18n.t("activerecord.attributes.countee.pet_count"), with: -1

    click_on I18n.t(
      "helpers.submit.create",
      model: I18n.t("activerecord.models.countee.one").to_s
    )

    assert_text I18n.t("common.error")

    fill_in I18n.t("activerecord.attributes.countee.pet_count"), with: 1

    click_on I18n.t(
      "helpers.submit.create",
      model: I18n.t("activerecord.models.countee.one").to_s
    )

    assert_text I18n.t("countees.create.notice")
  end

  test "deletes Countee" do
    sign_in users(:admin)

    visit counting_countees_url(@counting, locale: I18n.locale)
    click_on I18n.t("countees.destroy.title"), match: :first

    accept_alert

    assert_text I18n.t("countees.destroy.notice")
  end
end
