require 'test_helper'

# Countings controller test. Requires authorization as an admin for every action
class PeopleControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:alice) # Alice has role: admin
    @counting = countings(:one)
    @person = people(:one)
    @locale = 'de'
  end

  test 'should get index' do
    get counting_people_url(@counting, { locale: @locale })
    assert_response :success
  end

  test 'should get edit' do
    get edit_counting_person_url(@counting, @person, { locale: @locale })
    assert_response :success
  end

  test 'should update person' do
    patch counting_person_url(@counting, @person, { locale: @locale }), params: { person: { age_group: @person.age_group, gender: @person.gender, pet_count: @person.pet_count } }
    assert_redirected_to counting_people_url
  end

  test 'should delete person' do
    assert_difference('Person.count', -1) do
      delete counting_person_url(@counting, @person, { locale: @locale })
    end

    assert_redirected_to counting_people_url
  end
end
