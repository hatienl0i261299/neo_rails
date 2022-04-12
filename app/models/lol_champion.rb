# frozen_string_literal: true

class LolChampion < ApplicationRecord
  belongs_to :tree
  has_one_attached :avatar

  validate :validate_avatar

  def validate_avatar
    errors.add(:avatar, 'needs to be a jpeg or png!') if avatar.present? && avatar.attached? && !avatar.content_type.in?(%('image/jpeg image/png'))
  end

  # include MeiliSearch::Rails
  # meilisearch do
  #   attribute :name
  #   attribute :location
  #   attribute :quote
  #   attribute :summoner_spell
  #
  #   filterable_attributes [:location]
  #   sortable_attributes [:created_at, :updated_at]
  # end
end
