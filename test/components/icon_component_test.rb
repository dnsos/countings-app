# frozen_string_literal: true

require "test_helper"

class IconComponentTest < ViewComponent::TestCase
  test "renders a hamburger icon if specified" do
    render_inline(IconComponent.new(type: :hamburger))

    assert_selector('svg[data-icon-type="hamburger"]')
  end
  test "renders a close icon if specified" do
    render_inline(IconComponent.new(type: :close))

    assert_selector('svg[data-icon-type="close"]')
  end

  test "raises an appropriate error if invalid type is provided" do
    assert_raises(ArgumentError) do
      render_inline(IconComponent.new(type: :invalid))
    end
  end
end
