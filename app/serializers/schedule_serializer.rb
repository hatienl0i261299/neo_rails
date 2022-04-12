# frozen_string_literal: true

class ScheduleSerializer < ApplicationSerializer
  attributes :id, :time_start, :time_end, :created_at, :updated_at
end
