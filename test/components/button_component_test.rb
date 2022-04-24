# frozen_string_literal: true

require 'test_helper'

class ButtonComponentTest < ViewComponent::TestCase
  test 'renders a button by default' do
    render_inline(ButtonComponent.new) { 'I am a button' }

    assert_selector('button[type=button]', text: 'I am a button')
  end

  test 'renders a submit button if specified' do
    render_inline(ButtonComponent.new(type: :submit, path: '/')) do
      'I am a submit button'
    end

    assert_selector('button[type=submit]', text: 'I am a submit button')
  end

  test 'raises an appropriate error if submit button without path provided' do
    assert_raises(ArgumentError) do
      render_inline(ButtonComponent.new(type: :submit)) do
        'I am a submit going nowhere'
      end
    end
  end

  test 'renders a link element if specified' do
    render_inline(ButtonComponent.new(tag: :a, href: '#')) { 'I am a link' }

    assert_selector('a', text: 'I am a link')
  end

  test 'raises an appropriate error if link without href provided' do
    assert_raises(ArgumentError) do
      render_inline(ButtonComponent.new(tag: :a)) do
        'I am a link going nowhere'
      end
    end
  end

  # NOTE: The following tests asserting class names are slightly brittle considering they will break if, e.g., the background color is slightly modified:
  test 'renders secondary scheme by default' do
    render_inline(ButtonComponent.new) { 'Secondary button' }

    assert_selector(
      'button.border-blue-300.text-blue-50',
      text: 'Secondary button',
    )
  end

  test 'renders primary scheme if specified' do
    render_inline(ButtonComponent.new(scheme: :primary)) { 'Primary button' }

    assert_selector(
      'button.bg-yellow-300.text-blue-900',
      text: 'Primary button',
    )
  end

  test 'renders danger scheme if specified' do
    render_inline(ButtonComponent.new(scheme: :danger)) { 'Danger button' }

    assert_selector('button.text-danger.border-danger', text: 'Danger button')
  end

  test 'renders link scheme if specified' do
    render_inline(ButtonComponent.new(scheme: :link)) { 'Link button' }

    assert_selector('button.bg-transparent.text-blue-200', text: 'Link button')
  end
end
