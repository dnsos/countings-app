# frozen_string_literal: true

require "test_helper"

class HeaderComponentTest < ViewComponent::TestCase
  # We need to include Rails' tag helpers if using content_tag in the test:
  include ActionView::Helpers::TagHelper

  test "renders its content" do
    render_inline(HeaderComponent.new) do |component|
      component.with_language_switch(
        label: "Please select a language"
      ) do |language_component|
        language_component.with_language_link do
          content_tag :a, "EN", href: "/en"
        end

        language_component.with_language_link do
          content_tag :a, "DE", href: "/de"
        end
      end

      component.with_link { content_tag :a, "Home", href: "/" }
    end

    assert_link("Home", href: "/")
    assert_link("DE", href: "/de")
    assert_link("EN", href: "/en")
  end
end
