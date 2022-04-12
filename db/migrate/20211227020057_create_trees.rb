# frozen_string_literal: true

class CreateTrees < ActiveRecord::Migration[6.1]
  def change
    create_table :trees do |t|
      t.string :name
      t.string :parent_path

      t.timestamps
    end

    add_index :trees, :parent_path
  end
end
