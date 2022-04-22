# AgeGroup model
class AgeGroup < ApplicationRecord
  validates :min_age, presence: true
  validates :max_age, comparison: { greater_than: :min_age }

  has_many :people

  def label
    min_age && max_age ? "#{min_age} - #{max_age}" : "#{min_age}+"
  end
end
