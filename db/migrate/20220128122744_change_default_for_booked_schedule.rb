# frozen_string_literal: true

class ChangeDefaultForBookedSchedule < ActiveRecord::Migration[6.1]
  def change
    change_column :nurse_schedules, :booked, :boolean, default: false
    change_column :nurses, :phone, :bigint
  end
end
