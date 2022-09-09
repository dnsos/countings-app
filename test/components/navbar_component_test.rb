# frozen_string_literal: true

require 'test_helper'

class NavbarComponentTest < ViewComponent::TestCase
  test 'renders its navbar items' do
    render_inline(NavbarComponent.new) do |component|
      component.navbar_item(title: 'Home', href: '/')
      component.navbar_item(title: 'Account', href: '/account')
    end

    assert_selector('nav')
    assert_selector('ul')
    assert_selector('li', count: 2)
    assert_selector('a', count: 2)

    assert_link('Home', href: '/')
    assert_link('Account', href: '/account')
  end
end
