# Counting
class Counting < ApplicationRecord
  has_rich_text :description_long

  validates :title, :starts_at, :ends_at, presence: true
  validates :ends_at,
    comparison: {
      greater_than: :starts_at
    },
    unless: -> { starts_at.blank? }

  belongs_to :user

  has_many :counting_signups, dependent: :destroy
  has_many :counting_areas, dependent: :destroy

  has_many :countees, dependent: :destroy

  scope :closest_first, -> { order("starts_at ASC") }
  scope :past, -> { where("ends_at < ?", Time.now) }
  scope :upcoming, -> { where("ends_at > ?", Time.now) }

  def ongoing?
    Time.now.between? starts_at, ends_at
  end

  def signups_allowed?
    Time.now.before? starts_at - 7.days
  end

  def area_assignments_allowed?
    !signups_allowed? && Time.now.before?(starts_at) && !ongoing?
  end
end
