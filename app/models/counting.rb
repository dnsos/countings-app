class Counting < ApplicationRecord
  validates :title, presence: true
  validates :ends_at, comparison: { greater_than: :starts_at }
end
