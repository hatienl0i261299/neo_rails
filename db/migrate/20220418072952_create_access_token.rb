# frozen_string_literal: true

class CreateAccessToken < ActiveRecord::Migration[7.0]
  def change
    create_table :access_tokens do |t|
      t.string :token
      t.string :renew_token
      t.references :user, null: false, foreign: true

      t.timestamps
    end
  end
end
