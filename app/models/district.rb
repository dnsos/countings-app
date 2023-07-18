class District < ApplicationRecord
  validates :name, :geometry, presence: true

  has_many :countees
end
