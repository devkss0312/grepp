class CreateExamSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :exam_slots do |t|
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
