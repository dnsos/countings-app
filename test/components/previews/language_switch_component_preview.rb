# frozen_string_literal: true

# NOTE: Preview not working, throws error.
# TODO: check later why this is.
class LanguageSwitchComponentPreview < ViewComponent::Preview
  def default
    render(
      LanguageSwitchComponent.new(label: 'Please selct a language'),
    ) do |component|
      component.with_language_link(scheme: :link, tag: :a, href: '/de') do
        'Deutsch'
      end
      component.with_language_link(scheme: :link, tag: :a, href: '/en') do
        'English'
      end
    end
  end
end
