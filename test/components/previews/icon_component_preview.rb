# frozen_string_literal: true

# IconComponentPreview
class IconComponentPreview < ViewComponent::Preview
  # @!group Types
  def hamburger(type: :hamburger)
    render(IconComponent.new(typs: type))
  end

  def close(type: :close)
    render(IconComponent.new(type: type))
  end
  # @!endgroup
end
