class AreaAssignment < ApplicationRecord
  belongs_to :counting_area
  belongs_to :counting_signup

  validates :counting_area, uniqueness: true
end
