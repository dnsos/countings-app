# frozen_string_literal: true

class CounteeCardComponentPreview < ViewComponent::Preview
  def default
    render(
      CounteeCardComponent.new(
        created_at: Time.now - 13.minutes,
        district: 'Friedrichshain-Kreuzberg',
        gender: 'Männlich/Male',
        age_group: '65+',
        pet_count: 3,
      ),
    )
  end
end
