require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DEFAULT_WINDOW_SIZE = [1400, 1400].freeze

  # TODO: test the much more likely mobile screen size
  driven_by :selenium, using: :headless_chrome, screen_size: DEFAULT_WINDOW_SIZE

  Capybara.enable_aria_label = true

  teardown do
    Capybara.current_session.current_window.resize_to(*DEFAULT_WINDOW_SIZE)
  end
end
