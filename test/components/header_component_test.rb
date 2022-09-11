# frozen_string_literal: true

require 'test_helper'

class HeaderComponentTest < ViewComponent::TestCase
  test 'renders its content' do
    render_inline(HeaderComponent.new) { 'I am in the content area' }

    assert_text 'I am in the content area'
  end
end
