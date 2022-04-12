# frozen_string_literal: true

class UpdateForMedia < ActiveRecord::Migration[6.1]
  def change
    change_column :lol_champions, :tree_id, :bigint, null: true
    change_column :pokemon_pets, :tree_id, :bigint, null: true
    change_column :media_conans, :tree_id, :bigint, null: true
    change_column :media_one_pieces, :tree_id, :bigint, null: true
  end
end
