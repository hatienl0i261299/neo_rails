# frozen_string_literal: true

class PokemonPet < ApplicationRecord
  belongs_to :tree

  scope :get_info_pokemon_pet, lambda {
    select(
      [
        'pokemon_pets.id',
        'pokemon_pets.name',
        'pokemon_pets.location',
        'pokemon_pets.move',
        'pokemon_pets.created_at',
        'pokemon_pets.updated_at',
        'trees.id as tree_id',
        'trees.name as tree_name'
      ].join(', ')
    )
  }
end
