# frozen_string_literal: true

class Schedule < ApplicationRecord
  has_many :nurse_schedules, dependent: :destroy
  has_many :nurses, through: :nurse_schedules
  validates :time_start,
            presence: true,
            format: { with: /:/, message: '"%{value}" is not a format for time_start' },
            on: %i[create update]
  validates :time_end,
            presence: true,
            format: { with: /:/, message: '"%{value}" is not a format for time_end' },
            on: %i[create update]
end
