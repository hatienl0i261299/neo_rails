# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.string :time_start
      t.string :time_end

      t.timestamps
    end
  end
end
