# frozen_string_literal: true

require_relative '20211212041911_create_messages'

class UpdateForeignKeyForMessage < ActiveRecord::Migration[6.1]
  def change
    revert CreateMessages

    create_table :messages do |t|
      t.references :user, null: true, foreign_key: true
      t.string :content
      t.boolean :read

      t.timestamps
    end
  end
end
