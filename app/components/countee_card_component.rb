# frozen_string_literal: true

class CounteeCardComponent < ViewComponent::Base
  def initialize(
    created_at: nil,
    district: nil,
    gender: nil,
    age_group: nil,
    pet_count: nil,
    **args
  )
    @created_at = created_at
    @district = district
    @gender = gender
    @age_group = age_group
    @pet_count = pet_count

    @args = args

    @args[:class] =
      class_names(
        @args[:class],
        'p-3 rounded-md border border-blue-600 bg-transparent',
      )
  end
end
