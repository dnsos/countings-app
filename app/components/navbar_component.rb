# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  renders_many :navbar_items, NavbarItemComponent

  def initialize(**args)
    @args = args

    @args[:class] =
      class_names(
        'w-full',
        'bg-blue-900 border-t border-blue-500',
        'z-50',
        @args[:class],
      )
    @ul_classes =
      class_names('w-full', 'flex flex-nowrap place-items-stretch gap-0')
  end
end
