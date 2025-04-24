class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam_slot, null: false, foreign_key: true
      t.integer :expected_attendees
      t.boolean :confirmed

      t.timestamps
    end
  end
end
