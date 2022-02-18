require 'application_system_test_case'

class CountingsTest < ApplicationSystemTestCase
  setup do
    @counting = countings(:one)
  end

  test 'visiting the index' do
    visit countings_url
    assert_selector 'h1', text: 'Countings'
  end

  test 'should create counting' do
    visit countings_url
    click_on 'New counting'

    fill_in 'Description', with: @counting.description
    fill_in 'Ends at', with: @counting.ends_at
    fill_in 'Starts at', with: @counting.starts_at
    fill_in 'Title', with: @counting.title
    click_on 'Create Counting'

    assert_text 'Counting was successfully created'
    click_on 'Back'
  end

  test 'should update Counting' do
    visit counting_url(@counting)
    click_on 'Edit this counting', match: :first

    fill_in 'Description', with: @counting.description
    fill_in 'Ends at', with: @counting.ends_at
    fill_in 'Starts at', with: @counting.starts_at
    fill_in 'Title', with: @counting.title
    click_on 'Update Counting'

    assert_text 'Counting was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Counting' do
    visit counting_url(@counting)
    click_on 'Destroy this counting', match: :first

    assert_text 'Counting was successfully destroyed'
  end
end
