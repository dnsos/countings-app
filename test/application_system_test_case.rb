require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # TODO: test the much more likely mobile screen size
  driven_by :selenium, using: :headless_firefox, screen_size: [1400, 1400]
end
