class District < ApplicationRecord
  validates :name, :geometry, presence: true
end
