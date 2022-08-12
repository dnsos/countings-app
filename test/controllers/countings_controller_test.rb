require 'test_helper'

# Countings controller test. Requires authorization as an admin for everything except index and show
class CountingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
    I18n.locale = :de
  end

  test 'should get index' do
    get countings_url(locale: I18n.locale)
    assert_response :success
  end

  test 'should get index of past countings' do
    get countings_url(locale: I18n.locale, status: :past)
    assert_response :success
  end

  test 'should get new' do
    get new_counting_url
    assert_response :success
  end

  test 'should not be allowed' do
    sign_in users(:bob) # Bob does not have role: admin
    get new_counting_url
    assert_response :not_found
  end

  test 'should create counting' do
    assert_difference('Counting.count') do
      post countings_url,
           params: {
             counting: {
               description_short: @counting.description_short,
               ends_at: @counting.ends_at,
               starts_at: @counting.starts_at,
               title: @counting.title,
             },
           }
    end

    assert_redirected_to counting_url(Counting.last)
  end

  test 'should reject creating a counting due to invalid params' do
    post countings_url,
         params: {
           counting: {
             description_short: @counting.description_short,
             # Notice that starts_at and ends_at are interchanged here
             ends_at: @counting.starts_at,
             starts_at: @counting.ends_at,
             title: @counting.title,
           },
         }

    assert_response :unprocessable_entity
  end

  test 'should show counting' do
    get counting_url(@counting, { locale: I18n.locale })
    assert_response :success
  end

  test 'should get edit' do
    get edit_counting_url(@counting, { locale: I18n.locale })
    assert_response :success
  end

  test 'should update counting' do
    patch counting_url(@counting, { locale: I18n.locale }),
          params: {
            counting: {
              description_short: @counting.description_short,
              ends_at: @counting.ends_at,
              starts_at: @counting.starts_at,
              title: @counting.title,
            },
          }
    assert_redirected_to counting_url(@counting)
  end

  test 'should reject updating a counting due to invalid params' do
    patch counting_url(@counting, { locale: I18n.locale }),
          params: {
            counting: {
              description_short: @counting.description_short,
              # Notice that starts_at and ends_at are interchanged here
              ends_at: @counting.starts_at,
              starts_at: @counting.ends_at,
              title: @counting.title,
            },
          }
    assert_response :unprocessable_entity
  end

  test 'should destroy counting' do
    assert_difference('Counting.count', -1) do
      delete counting_url(@counting, { locale: I18n.locale })
    end

    assert_redirected_to countings_url
  end
end
