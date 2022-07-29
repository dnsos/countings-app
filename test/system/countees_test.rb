require 'application_system_test_case'

class CounteesTest < ApplicationSystemTestCase
  setup { @countee = countees(:one) }

  test 'visiting the index' do
    visit countees_url
    assert_selector 'h1', text: 'Countees'
  end

  test 'should create countee' do
    visit countees_url
    click_on 'New countee'

    fill_in 'Age group', with: @countee.age_group_id
    fill_in 'Counting', with: @countee.counting_id
    fill_in 'District', with: @countee.district_id
    fill_in 'Gender', with: @countee.gender_id
    fill_in 'Pet count', with: @countee.pet_count
    click_on 'Create Countee'

    assert_text 'Countee was successfully created'
    click_on 'Back'
  end

  test 'should update Countee' do
    visit countee_url(@countee)
    click_on 'Edit this countee', match: :first

    fill_in 'Age group', with: @countee.age_group_id
    fill_in 'Counting', with: @countee.counting_id
    fill_in 'District', with: @countee.district_id
    fill_in 'Gender', with: @countee.gender_id
    fill_in 'Pet count', with: @countee.pet_count
    click_on 'Update Countee'

    assert_text 'Countee was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Countee' do
    visit countee_url(@countee)
    click_on 'Destroy this countee', match: :first

    assert_text 'Countee was successfully destroyed'
  end
end
