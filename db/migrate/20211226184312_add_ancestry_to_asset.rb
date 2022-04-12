# frozen_string_literal: true

class AddAncestryToAsset < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :ancestry, :string
    add_index :assets, :ancestry
  end
end
