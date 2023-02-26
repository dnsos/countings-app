# frozen_string_literal: true

class HiddenComponent < ViewComponent::Base
  def initialize(**args)
    @args = args
    @args[:class] = class_names("!hidden", @args[:class])
  end

  def call
    content_tag :div, nil, "aria-hidden": true, **@args
  end
end
