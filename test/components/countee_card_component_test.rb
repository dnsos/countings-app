# frozen_string_literal: true

require 'test_helper'

class CounteeCardComponentTest < ViewComponent::TestCase
  test 'renders the minimum required information' do
    render_inline(
      CounteeCardComponent.new(
        created_at: Time.new(2022, 10, 13, 16, 45, 34),
        counting_area: 'Warschauer Straße',
      ),
    )

    assert_selector('h3', text: 'Warschauer Straße')
    assert_selector('time')
  end

  test 'renders all information if provided' do
    render_inline(
      CounteeCardComponent.new(
        created_at: Time.new(2022, 10, 13, 16, 45, 34),
        counting_area: 'Warschauer Straße',
        gender: 'Male',
        age_group: '65+',
        pet_count: 2,
      ),
    )

    assert_selector('h3', text: 'Warschauer Straße')
    assert_selector('time')

    assert_text('Male')
    assert_text('65+')
    assert_text('2')
  end
end
