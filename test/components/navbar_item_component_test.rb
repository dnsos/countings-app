# frozen_string_literal: true

require 'test_helper'

class NavbarItemComponentTest < ViewComponent::TestCase
  test 'renders what is passed to it' do
    render_inline(
      NavbarItemComponent.new(
        title: 'Nav item about testing',
        href: 'https://guides.rubyonrails.org/testing.html',
        data: {
          test: 'thing',
        },
      ),
    )

    assert_selector(
      'a[href=\'https://guides.rubyonrails.org/testing.html\']',
      text: 'Nav item about testing',
    )
    assert_selector('a[data-test=\'thing\']')
  end
end
