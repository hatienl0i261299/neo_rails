# frozen_string_literal: true

require_relative '../../common/helper'

class MediaOnePieceSerializer < ApplicationSerializer
  attributes :id,
             :character,
             :sea,
             :location,
             :quote,
             :skill,
             :tree,
             :created_at,
             :updated_at

  # def tree
  #   {
  #     id: object.tree_id,
  #     name: object.tree_name,
  #     parent_path: object.tree_parent_path,
  #     created_at: object.tree_created_at.strftime(FORMAT_DATETIME_OUTPUT),
  #     updated_at: object.tree_updated_at.strftime(FORMAT_DATETIME_OUTPUT)
  #   }
  # end
end
