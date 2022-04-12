# frozen_string_literal: true

class CreateMediaOnePieces < ActiveRecord::Migration[6.1]
  def change
    create_table :media_one_pieces do |t|
      t.string :character
      t.string :sea
      t.string :location
      t.string :quote
      t.string :skill
      t.references :tree, null: false, foreign_key: true

      t.timestamps
    end
  end
end
