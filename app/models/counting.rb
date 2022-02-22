class Counting < ApplicationRecord
  validates :title, :starts_at, :ends_at, presence: true
  validates :ends_at, comparison: { greater_than: :starts_at }, unless: -> { starts_at.blank? }

  belongs_to :user
end
