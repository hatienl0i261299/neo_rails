# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: false
      t.string :content
      t.boolean :read

      t.timestamps
    end
  end
end
