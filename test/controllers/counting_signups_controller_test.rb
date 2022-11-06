require 'test_helper'

class CountingSignupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @counting = countings(:future)
    I18n.locale = :de
  end

  test 'displays counting_signups to admin user' do
    sign_in users(:admin)

    get counting_counting_signups_url(
          counting_id: @counting.id,
          locale: I18n.locale,
        )
    assert_response :success
  end

  test 'rejects to show counting_signups to regular user' do
    sign_in users(:regular)

    get counting_counting_signups_url(
          counting_id: @counting.id,
          locale: I18n.locale,
        )
    assert_response :not_found
  end

  test 'creates counting_signup when user is not already signed up' do
    sign_in users(:alice)

    assert_difference('CountingSignup.count') do
      post counting_counting_signups_url(
             counting_id: @counting.id,
             locale: I18n.locale,
           )
    end

    assert_redirected_to counting_url(@counting)
  end

  test 'rejects counting_signup when user is already signed up' do
    sign_in users(:regular)

    assert_no_difference('CountingSignup.count') do
      post counting_counting_signups_url(
             counting_id: @counting.id,
             locale: I18n.locale,
           )
    end

    assert_response :unprocessable_entity
  end

  test 'destroys counting_signup of an already registered user' do
    sign_in users(:regular)

    assert_difference('CountingSignup.count', -1) do
      delete counting_counting_signup_path(
               counting_id: @counting,
               id:
                 @counting.counting_signups.find_by(
                   user_id: users(:regular).id,
                 ),
             )
    end
    assert_redirected_to counting_url(@counting)
  end
end
