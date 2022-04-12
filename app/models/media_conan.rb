# frozen_string_literal: true

class MediaConan < ApplicationRecord
  belongs_to :tree
  has_one_attached :avatar # dependent: :nullify

  validates :character, presence: true

  validate :validate_avatar

  def validate_avatar
    errors.add(:avatar, 'needs to be a jpeg or png!') if avatar.present? && avatar.attached? && !avatar.content_type.in?(%('image/jpeg image/png'))
  end

  scope :get_info_media_conan, lambda {
    select(
      [
        'media_conans.id',
        'media_conans.character',
        'media_conans.gadget',
        'media_conans.vehicle',
        'media_conans.created_at',
        'media_conans.updated_at',
        'trees.id as tree_id',
        'trees.name as tree_name'
      ].join(', ')
    )
  }
end
