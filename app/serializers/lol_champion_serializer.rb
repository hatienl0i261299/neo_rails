# frozen_string_literal: true

class LolChampionSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :location,
             :quote,
             :summoner_spell,
             :tree,
             :avatar,
             :created_at,
             :updated_at

  def avatar
    object.avatar.blob
  end

  # def tree
  #   {
  #     id: object.tree_id,
  #     name: object.tree_name
  #   }
  # end
end
