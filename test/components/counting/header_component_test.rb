# frozen_string_literal: true

require 'test_helper'

class Counting
  class HeaderComponentTest < ViewComponent::TestCase
    test 'renders title, starts_at, ends_at and remaining time for ongoing counting' do
      starts_at = Time.now - 1.day
      ends_at = Time.now + 1.day

      render_inline(
        Counting::HeaderComponent.new(
          title: 'Some title',
          starts_at: starts_at,
          ends_at: ends_at,
        ),
      )

      assert_text 'Some title'
      assert_selector('time', count: 2)
      assert_selector('h2', text: I18n.t('common.remaining'))
    end

    test 'does not render remaining time for concluded counting' do
      starts_at = Time.now - 5.days
      ends_at = Time.now - 4.days

      render_inline(
        Counting::HeaderComponent.new(
          title: 'Some title',
          starts_at: starts_at,
          ends_at: ends_at,
        ),
      )

      assert_no_selector('h2', text: I18n.t('common.remaining'))
    end
  end
end
