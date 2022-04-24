# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  DEFAULT_SCHEME = :secondary

  SCHEME_MAPPINGS = {
    DEFAULT_SCHEME =>
      'border-blue-300 text-blue-50 transition-colors hover:border-blue-50 hover:text-yellow-200 focus:ring-2 focus:ring-offset-2 focus:ring-yellow-300 focus:ring-offset-blue-900 focus:outline-none',
    :primary =>
      'bg-yellow-300 text-blue-900 border-transparent transition-colors hover:bg-yellow-500 focus:ring-2 focus:ring-offset-2 focus:ring-yellow-300 focus:ring-offset-blue-900 focus:outline-none',
    :danger =>
      'border-danger text-danger transition-colors hover:bg-danger hover:text-white focus:ring-2 focus:ring-offset-2 focus:ring-danger focus:ring-offset-blue-900 focus:outline-none',
    :link =>
      'bg-transparent text-blue-200 border-transparent transition-colors hover:text-blue-50 focus:ring-2 focus:ring-offset-2 focus:ring-yellow-300 focus:ring-offset-blue-900 focus:outline-none',
  }.freeze
  SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

  DEFAULT_SIZE = :medium
  SIZE_MAPPINGS = {
    :small => 'text-sm py-1 px-2',
    DEFAULT_SIZE => 'text-base py-2 px-3',
  }.freeze
  SIZE_OPTIONS = SIZE_MAPPINGS.keys

  def initialize(
    scheme: DEFAULT_SCHEME,
    size: :medium,
    tag: :button,
    href: nil,
    path: nil,
    type: :button,
    additional_classes: '',
    **args
  )
    @scheme = scheme
    @tag = tag
    @size = size
    @href = href
    @path = path
    @type = type
    @additional_classes = additional_classes

    @args = args
    @args[:type] = @tag == :a ? nil : @type
    @args[:class] =
      class_names(
        @args[:class],
        'border font-medium inline-block h-min',
        SCHEME_MAPPINGS[
          fetch_or_fallback(SCHEME_OPTIONS, @scheme, DEFAULT_SCHEME)
        ],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
        @additional_classes,
      )
  end

  private

  def fetch_or_fallback(allowed_values, given_value, fallback = nil)
    allowed_values.include?(given_value) ? given_value : fallback
  end
end
