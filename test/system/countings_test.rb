require "application_system_test_case"

# Countings system test
class CountingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:one)
    I18n.locale = :de
  end

  test "visiting the index" do
    visit countings_url(locale: I18n.locale)
    assert_selector "h1", text: I18n.t("activerecord.models.counting.other")
  end

  test "should create counting" do
    sign_in users(:alice) # Alice has role: admin

    visit countings_url(locale: I18n.locale)
    click_on I18n.t("countings.new.title")

    fill_in I18n.t("activerecord.attributes.counting.description_short"),
      with: @counting.description_short
    fill_in I18n.t("activerecord.attributes.counting.ends_at"),
      with: @counting.ends_at
    fill_in I18n.t("activerecord.attributes.counting.starts_at"),
      with: @counting.starts_at
    fill_in I18n.t("activerecord.attributes.counting.title"),
      with: @counting.title
    click_on I18n.t(
      "helpers.submit.create",
      model: I18n.t("activerecord.models.counting.one").to_s
    )

    assert_text I18n.t("countings.create.notice")
    click_on I18n.t("countings.index.title.default")
  end

  test "should update Counting" do
    sign_in users(:alice) # Alice has role: admin

    visit counting_url(@counting, locale: I18n.locale)
    click_on I18n.t("countings.edit.explicitly"), match: :first

    fill_in I18n.t("activerecord.attributes.counting.description_short"),
      with: @counting.description_short
    fill_in I18n.t("activerecord.attributes.counting.ends_at"),
      with: @counting.ends_at
    fill_in I18n.t("activerecord.attributes.counting.starts_at"),
      with: @counting.starts_at
    fill_in I18n.t("activerecord.attributes.counting.title"),
      with: @counting.title
    click_on I18n.t(
      "helpers.submit.update",
      model: I18n.t("activerecord.models.counting.one").to_s
    )

    assert_text I18n.t("countings.update.notice")
    click_on I18n.t("countings.index.title.default")
  end

  test "should destroy Counting" do
    sign_in users(:alice) # Alice has role: admin

    visit edit_counting_url(@counting, locale: I18n.locale)
    click_on I18n.t("countings.destroy.explicitly"), match: :first

    accept_alert

    assert_text I18n.t("countings.destroy.notice")
  end
end
