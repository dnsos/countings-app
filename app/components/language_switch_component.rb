# frozen_string_literal: true

class LanguageSwitchComponent < ViewComponent::Base
  renders_many :language_links, ButtonComponent

  def initialize(label:)
    @label = label
  end
end
