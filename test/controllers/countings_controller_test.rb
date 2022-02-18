require 'test_helper'

# Countings controller test. Requires authorization as an admin for everything except index and show
class CountingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
  end

  test 'should get index' do
    get countings_url
    assert_response :success
  end

  test 'should get new' do
    get new_counting_url
    assert_response :success
  end

  test 'should create counting' do
    assert_difference('Counting.count') do
      post countings_url, params: { counting: { description: @counting.description, ends_at: @counting.ends_at, starts_at: @counting.starts_at, title: @counting.title } }
    end

    assert_redirected_to counting_url(Counting.last)
  end

  test 'should show counting' do
    get counting_url(@counting)
    assert_response :success
  end

  test 'should get edit' do
    get edit_counting_url(@counting)
    assert_response :success
  end

  test 'should update counting' do
    patch counting_url(@counting), params: { counting: { description: @counting.description, ends_at: @counting.ends_at, starts_at: @counting.starts_at, title: @counting.title } }
    assert_redirected_to counting_url(@counting)
  end

  test 'should destroy counting' do
    assert_difference('Counting.count', -1) do
      delete counting_url(@counting)
    end

    assert_redirected_to countings_url
  end
end
