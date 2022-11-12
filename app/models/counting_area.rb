class CountingArea < ApplicationRecord
  validates :geometry, presence: true

  belongs_to :counting

  has_one :area_assignment
end
