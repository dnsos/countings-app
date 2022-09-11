# frozen_string_literal: true

class HeaderComponentPreview < ViewComponent::Preview
  # Header
  # ----------------
  #
  # @param content text
  def default(content: 'Here could be a long page title')
    render(HeaderComponent.new) { content }
  end
end
