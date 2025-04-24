class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :exam_slot

  validates :expected_attendees, presence: true
  validates :confirmed, inclusion: { in: [true, false] }
end