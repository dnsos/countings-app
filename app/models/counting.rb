# Counting
class Counting < ApplicationRecord
  has_rich_text :description_long

  validates :title, :starts_at, :ends_at, presence: true
  validates :ends_at,
            comparison: {
              greater_than: :starts_at,
            },
            unless: -> { starts_at.blank? }

  belongs_to :user

  has_many :counting_signups, dependent: :destroy
  has_many :counting_areas, dependent: :destroy

  has_many :countees, dependent: :destroy

  scope :past, -> { where('ends_at < ?', Time.now) }
  scope :upcoming, -> { where('ends_at > ?', Time.now) }

  def ongoing?
    Time.now.between? starts_at, ends_at
  end

  MIN_TIME_BEFORE_COUNTING = 7.days
  def signups_allowed?
    Time.now.before? starts_at - MIN_TIME_BEFORE_COUNTING
  end
end
