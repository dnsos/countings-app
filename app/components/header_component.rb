# frozen_string_literal: true

class HeaderComponent < ViewComponent::Base
  renders_one :link
  renders_one :language_switch, LanguageSwitchComponent

  def initialize(**args)
    @args = args

    @args[:class] =
      class_names(
        "order-first",
        "w-full h-14",
        "py-3 px-5",
        "bg-blue-900 border-b border-blue-500",
        "grid grid-cols-[1fr,auto] gap-2 items-center",
        "z-50"
      )
  end
end
