# frozen_string_literal: true

class CreateMediaConans < ActiveRecord::Migration[6.1]
  def change
    create_table :media_conans do |t|
      t.string :character
      t.string :gadget
      t.string :vehicle
      t.references :tree, null: false, foreign_key: true

      t.timestamps
    end
  end
end
