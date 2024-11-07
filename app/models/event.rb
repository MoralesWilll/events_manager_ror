class Event < ApplicationRecord
  # Ensure the name is present and is not too long
  validates :name, presence: true, length: { maximum: 100 }

  # Ensure the date is present and is in the future
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  # Ensure the description is present and not too long
  validates :description, presence: true, length: { maximum: 500 }

  # Scopes
  # scope :added_in_last_30_days, -> { where("created_at >= ?", 30.days.ago) }
  scope :concert_events, -> { where("description LIKE ?", "%concert%") }

  private

  # Custom date validation to check that the event's date is not in the past
  def date_cannot_be_in_the_past
    if date.present? && date < Time.current
      errors.add(:date, "can't be in the past")
    end
  end
end
