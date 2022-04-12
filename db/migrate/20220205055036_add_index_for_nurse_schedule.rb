# frozen_string_literal: true

class AddIndexForNurseSchedule < ActiveRecord::Migration[6.1]
  def change
    add_index :nurse_schedules, %i[nurse_id schedule_id], unique: true
  end
end
