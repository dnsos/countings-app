# frozen_string_literal: true

class AreaAssignment::LastDestroyedComponent < ViewComponent::Base
  def initialize(id: nil)
    @id = id
  end
end
