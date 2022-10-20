class CountingArea < ApplicationRecord
  validates :geometry, presence: true

  belongs_to :counting
end
