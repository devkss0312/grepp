module Api
  module V1
    class ExamSlotsController < ApplicationController
      def index
        slots = ExamSlot.order(:start_time)

        exam_slots_data = slots.map do |slot|
          confirmed = slot.confirmed_attendees_count
          is_full = confirmed >= ExamSlot::MAX_ATTENDEES
          is_time_restricted = slot.start_time < ExamSlot::RESERVATION_DEADLINE_DAYS.days.from_now

          {
            id: slot.id,
            start_time: slot.start_time,
            end_time: slot.end_time,
            confirmed_attendees: confirmed,
            is_full: is_full,
            is_time_restricted: is_time_restricted
          }
        end

        render json: {
          meta: {
            max_attendees: ExamSlot::MAX_ATTENDEES,
            reservation_deadline_days: ExamSlot::RESERVATION_DEADLINE_DAYS
          },
          exam_slots: exam_slots_data
        }
      end
    end
  end
end
