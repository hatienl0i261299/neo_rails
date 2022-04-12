# frozen_string_literal: true

class NurseSerializer < ApplicationSerializer
  attributes :id, :name, :phone, :address, :schedules, :created_at, :updated_at

  def schedules
    object.schedules.as_json.map do |item|
      nurse_schedule = object.nurse_schedules.as_json.find_all { |val| val['schedule_id'] == item['id'] }[0]
      item.merge!(
        booked: nurse_schedule['booked'],
        nurse_schedule_id: nurse_schedule['id']
      )
    end
  end
end
