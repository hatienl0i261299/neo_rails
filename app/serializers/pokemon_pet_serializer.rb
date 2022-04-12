# frozen_string_literal: true

class PokemonPetSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :location,
             :move,
             :tree,
             :created_at,
             :updated_at

  def tree
    {
      id: object.tree_id,
      name: object.tree_name
    }
  end
end
