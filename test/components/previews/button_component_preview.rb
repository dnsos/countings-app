# frozen_string_literal: true

# ButtonComponentPreview
class ButtonComponentPreview < ViewComponent::Preview
  # As Button (default)
  # ----------------
  # Styled as a button, acts as a button. Note that in the component preview the additional_classes property might not be picked up because Tailwind automatically purges classes not present in the codebase. Also note that this component can not be used for each and every button, e.g. the submits in Rails form fields.
  #
  # @param content text
  # @param scheme [Symbol] select [primary, secondary, danger, link]
  # @param size [Symbol] select [small, medium]
  # @param additional_classes text
  # @label As Button (default)
  def as_button(scheme: :secondary, size: :medium, additional_classes: "", content: "I am a button")
    render(ButtonComponent.new(tag: :button, path: "", scheme:, size:, additional_classes:)) { content }
  end

  # As Link
  # ----------------
  # Styled as a button, acts as a link. Note that in the component preview the additional_classes property might not be picked up because Tailwind automatically purges classes not present in the codebase. Also note that this link can not be used for all links, e.g. the link_to_unless elements in the language navigation.
  #
  # @param content text
  # @param scheme [Symbol] select [primary, secondary, danger, link]
  # @param size [Symbol] select [small, medium]
  # @param additional_classes text
  # @label As Link
  def as_link(scheme: :secondary, size: :medium, additional_classes: "", content: "I am a link button")
    render(ButtonComponent.new(tag: :a, href: "#", scheme:, size:, additional_classes:)) { content }
  end
end
