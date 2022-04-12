# frozen_string_literal: true

class Book < ApplicationRecord
  # https://www.sitepoint.com/master-many-to-many-associations-with-activerecord/
  has_and_belongs_to_many :authors, -> { order(updated_at: :desc) }

  validates :title, presence: true, on: %i[update create]
  validates :content, presence: true
end
