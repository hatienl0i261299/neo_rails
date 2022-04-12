# frozen_string_literal: true

class CreateNurseSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :nurse_schedules do |t|
      t.boolean :booked
      t.references :schedule, null: false, foreign_key: true
      t.references :nurse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
