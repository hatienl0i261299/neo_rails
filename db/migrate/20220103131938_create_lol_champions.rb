# frozen_string_literal: true

class CreateLolChampions < ActiveRecord::Migration[6.1]
  def change
    create_table :lol_champions do |t|
      t.string :name
      t.string :location
      t.string :quote
      t.string :summoner_spell
      t.references :tree, null: false, foreign_key: true

      t.timestamps
    end
  end
end
