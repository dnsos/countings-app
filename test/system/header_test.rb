require 'application_system_test_case'

# Header system test
class HeaderTest < ApplicationSystemTestCase
  setup { I18n.locale = :de }

  MAIN_MENU_MATCHER = 'nav[aria-labelledby="main-menu-title"]'.freeze
  HIDDEN_MATCHER = 'sr-only'.freeze

  test 'changing the locale (on all screens)' do
    visit root_url locale: I18n.locale

    german_app_title = I18n.t('app.title', locale: :de).freeze
    assert_selector 'a', text: german_app_title

    click_button I18n.t('common.select_language')
    click_link I18n.t('locale_labels.en', locale: :de)

    english_app_title = I18n.t('app.title', locale: :en).freeze
    assert_selector 'a', text: english_app_title
  end

  test 'accessing the main menu on mobile' do
    # The hamburger menu is only visible on mobile screens:
    Capybara.current_session.current_window.resize_to(360, 740)

    visit root_url locale: I18n.locale

    has_css?("#{MAIN_MENU_MATCHER}.#{HIDDEN_MATCHER}") # -> main menu hidden by default

    click_on I18n.t('common.main_menu')

    has_no_css?("#{MAIN_MENU_MATCHER}.#{HIDDEN_MATCHER}") # -> main menu visible

    within(MAIN_MENU_MATCHER) do
      assert_selector 'a', text: I18n.t('activerecord.models.counting.other')
      assert_selector 'a', text: I18n.t('devise.sessions.new.sign_in')
      assert_selector 'a', text: I18n.t('devise.registrations.new.sign_up')
    end
  end

  test 'accessing the main menu on big screens' do
    visit root_url locale: I18n.locale

    has_no_css?("#{MAIN_MENU_MATCHER}.#{HIDDEN_MATCHER}")

    within(MAIN_MENU_MATCHER) do
      assert_selector 'a', text: I18n.t('activerecord.models.counting.other')
      assert_selector 'a', text: I18n.t('devise.sessions.new.sign_in')
      assert_selector 'a', text: I18n.t('devise.registrations.new.sign_up')
    end
  end
end
