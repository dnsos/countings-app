# frozen_string_literal: true

class NavbarItemComponent < ViewComponent::Base
  def initialize(title:, href:, **args)
    @title = title
    @href = href
    @args = args

    @args[:class] =
      class_names(
        'w-full py-3 px-2',
        'text-white',
        'bg-blue-900 transition-colors hover:bg-blue-800',
        'focus:outline-none focus:ring focus:ring-white focus:ring-inset',
        'grid gap-y-2 justify-center',
        @args[:class],
      )
  end
end
