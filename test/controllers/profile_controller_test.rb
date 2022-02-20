require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'authenticated user reaches profile page' do
    sign_in users(:alice)

    get profile_url
    assert_response :success
  end

  test 'unauthenticated user gets redirected to login' do
    get profile_url
    assert_response :found
  end
end
