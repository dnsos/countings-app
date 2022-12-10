require 'test_helper'

class CountingAreasControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @counting = countings(:ongoing)
    I18n.locale = :de
  end

  test 'should get index for admin user' do
    get counting_counting_areas_url(@counting, { locale: I18n.locale })
    assert_response :success
  end
end
