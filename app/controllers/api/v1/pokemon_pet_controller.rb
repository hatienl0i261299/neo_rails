# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class PokemonPetController < ApplicationController
      def index
        pokemon = PokemonPet
                  .get_info_pokemon_pet
                  .paging(params[:page], params[:per_page])
                  .left_joins(:tree)
                  .order(updated_at: :desc)
        render json: {
          **pagination(pokemon),
          data: pokemon.map { |item| PokemonPetSerializer.new(item).serializable_hash }
        }, status: :ok
      end
    end
  end
end
