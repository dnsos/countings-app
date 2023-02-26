# frozen_string_literal: true

# NavbarComponentPreview
class NavbarComponentPreview < ViewComponent::Preview
  def with_three_items
    render(NavbarComponent.new) do |component|
      component.navbar_item(title: "Home", href: "#")
      component.navbar_item(title: "Countings", href: "#")
      component.navbar_item(title: "Account", href: "#")
    end
  end

  def with_five_items
    render(NavbarComponent.new) do |component|
      component.navbar_item(title: "Home", href: "#")
      component.navbar_item(title: "Countings", href: "#")
      component.navbar_item(title: "Account", href: "#")
      component.navbar_item(title: "Something", href: "#")
      component.navbar_item(title: "Else", href: "#")
    end
  end
end
