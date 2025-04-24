class ExamSlot < ApplicationRecord

    MAX_ATTENDEES = 50_000
    RESERVATION_DEADLINE_DAYS = 3
    
    has_many :reservations
  
    validates :start_time, :end_time, presence: true
  
    def confirmed_attendees_count
      reservations.where(confirmed: true).sum(:expected_attendees)
    end
  end