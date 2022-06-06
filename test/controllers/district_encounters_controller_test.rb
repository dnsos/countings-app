require 'test_helper'

# DistrictEncountersControllerTest
class DistrictEncountersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
    @locale = 'de'
  end

  test 'should get index' do
    get counting_district_encounters_url(@counting, { locale: @locale })
    assert_response :success
  end
end
