# frozen_string_literal: true

class NurseScheduleSerializer < ApplicationSerializer
  attributes :id,
             :booked,
             :schedule_id,
             :nurse,
             :created_at,
             :updated_at
end
