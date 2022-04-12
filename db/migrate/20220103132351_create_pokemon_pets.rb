# frozen_string_literal: true

class CreatePokemonPets < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemon_pets do |t|
      t.string :name
      t.string :location
      t.string :move
      t.references :tree, null: false, foreign_key: true

      t.timestamps
    end
  end
end
