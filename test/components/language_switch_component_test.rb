# frozen_string_literal: true

require 'test_helper'

class LanguageSwitchComponentTest < ViewComponent::TestCase
  test 'renders the language switch component' do
    render_inline(
      LanguageSwitchComponent.new(label: 'Please select a language'),
    ) do |component|
      component.with_language_link(scheme: :link, tag: :a, href: '/de') do
        'Deutsch'
      end
      component.with_language_link(scheme: :link, tag: :a, href: '/en') do
        'English'
      end
    end

    assert_selector('nav', text: 'Please select a language')

    assert_link('Deutsch', href: '/de')
    assert_link('English', href: '/en')
  end
end
