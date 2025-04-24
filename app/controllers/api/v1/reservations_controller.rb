module Api
    module V1
      class ReservationsController < ApplicationController
        def create
          user = User.find_by(id: reservation_params[:user_id])
          exam_slot = ExamSlot.find_by(id: reservation_params[:exam_slot_id])
  
          if user.nil? || exam_slot.nil?
            return render json: { error: "Invalid user or exam slot" }, status: :bad_request
          end
  
          # 1. 시험 시작까지 3일 이하 남은 경우 → 예약 불가
          if exam_slot.start_time < 3.days.from_now
            return render json: { error: "예약은 시험 시작 3일 전까지만 가능합니다." }, status: :unprocessable_entity
          end
  
          # 2. 해당 시험 슬롯에 확정된 총 인원 + 이번 요청 인원이 5만 초과인 경우 → 예약 불가
          confirmed_count = exam_slot.confirmed_attendees_count
          expected_total = confirmed_count + reservation_params[:expected_attendees].to_i
  
          if expected_total > 50_000
            return render json: { error: "해당 시간대 예약 인원이 초과되었습니다." }, status: :unprocessable_entity
          end
  
          # 3. 예약 생성
          reservation = Reservation.new(reservation_params)
          reservation.confirmed = false
  
          if reservation.save
            render json: { message: "예약이 완료되었습니다.", reservation: reservation }, status: :created
          else
            render json: { error: reservation.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def reservation_params
          params.require(:reservation).permit(:user_id, :exam_slot_id, :expected_attendees)
        end
      end
    end
  end
  