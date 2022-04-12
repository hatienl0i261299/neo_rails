# frozen_string_literal: true

class Nurse < ApplicationRecord
  has_many :nurse_schedules, dependent: :destroy
  has_many :schedules, -> { order(id: :asc) }, through: :nurse_schedules
  validates_each :name do |record, attribute, value|
    record.errors.add attribute, "'#{value}' is not a valid type" unless value =~ /^[a-zA-Z]/
  end
  validates :phone, numericality: { only_integer: true }
end
