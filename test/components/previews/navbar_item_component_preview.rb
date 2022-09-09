# frozen_string_literal: true

# NavbarItemComponentPreview
class NavbarItemComponentPreview < ViewComponent::Preview
  # @!group Example items
  def home(title: 'Home')
    render(NavbarItemComponent.new(title: title, href: '#'))
  end

  def countings(title: 'Countings')
    render(NavbarItemComponent.new(title: title, href: '#'))
  end

  def account(title: 'Account')
    render(NavbarItemComponent.new(title: title, href: '#'))
  end
  # @!endgroup
end
