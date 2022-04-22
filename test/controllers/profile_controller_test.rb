require 'test_helper'

# Profile controller test
class ProfileControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup { @locale = 'de' }

  test 'authenticated user reaches profile page' do
    sign_in users(:alice)

    get profile_url(locale: @locale)
    assert_response :success
  end

  test 'unauthenticated user gets redirected to login' do
    get profile_url(locale: @locale)
    assert_response :found
  end
end
