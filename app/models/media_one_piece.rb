# frozen_string_literal: true

class MediaOnePiece < ApplicationRecord
  belongs_to :tree

  scope :get_info_media_one_piece, lambda {
    select(
      [
        'media_one_pieces.id',
        'media_one_pieces.character',
        'media_one_pieces.sea',
        'media_one_pieces.location',
        'media_one_pieces.quote',
        'media_one_pieces.skill',
        'media_one_pieces.created_at',
        'media_one_pieces.updated_at',
        'trees.id as tree_id',
        'trees.name as tree_name',
        'trees.parent_path as tree_parent_path',
        'trees.created_at as tree_created_at',
        'trees.updated_at as tree_updated_at'
      ].map(&:strip).join(', ')
    )
  }
end
