# frozen_string_literal: true

class IconComponent < ViewComponent::Base
  TYPE_OPTIONS = %i[hamburger close language].freeze

  def initialize(type:, **args)
    @type = type

    @args = args
    @args[:class] =
      class_names(
        @args[:class],
        'block',
        'w-6 h-6', # SIZE
      )
  end

  def before_render
    unless TYPE_OPTIONS.include? @type
      raise ArgumentError, "There is no icon with the type '#{@type}'"
    end
  end
end
