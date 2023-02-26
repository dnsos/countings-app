# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  # NOTE: All styles (beginning with `button-`) are defined in app/assets/stylesheets/application.tailwind.css
  # This is because not each and every button-looking element in the app can be created using this component (e.g. submits in Rails forms). So that styles are defined in the CSS file as the single source of truth.
  DEFAULT_SCHEME = :secondary

  SCHEME_MAPPINGS = {
    DEFAULT_SCHEME => "button-secondary",
    :primary => "button-primary",
    :danger => "button-danger",
    :link => "button-link"
  }.freeze
  SCHEME_OPTIONS = SCHEME_MAPPINGS.keys

  DEFAULT_SIZE = :medium
  SIZE_MAPPINGS = {
    :small => "button-small",
    DEFAULT_SIZE => "button-medium"
  }.freeze
  SIZE_OPTIONS = SIZE_MAPPINGS.keys

  def initialize(
    scheme: DEFAULT_SCHEME,
    size: :medium,
    tag: :button,
    href: nil,
    path: nil,
    type: :button,
    additional_classes: "",
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
    @args[:type] = (@tag == :a) ? nil : @type
    @args[:class] =
      class_names(
        @args[:class],
        "button",
        SCHEME_MAPPINGS[
          fetch_or_fallback(SCHEME_OPTIONS, @scheme, DEFAULT_SCHEME)
        ],
        SIZE_MAPPINGS[fetch_or_fallback(SIZE_OPTIONS, @size, DEFAULT_SIZE)],
        @additional_classes
      )
  end

  def before_render
    if @tag == :a && @href.nil? && !Rails.env.production?
      raise ArgumentError, "href is required when using <a> tag"
    end

    if @tag == :button && @type == :submit && @path.nil? &&
        !Rails.env.production?
      raise ArgumentError, "path is required when using a submit button"
    end
  end

  private

  def fetch_or_fallback(allowed_values, given_value, fallback = nil)
    allowed_values.include?(given_value) ? given_value : fallback
  end
end
