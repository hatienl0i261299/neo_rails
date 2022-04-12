# frozen_string_literal: true

class JoinArticleAndGenre < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :genre, null: false, foreign_key: true

    add_index :articles, "to_tsvector('english', title)", using: :gin
    add_index :genres, "to_tsvector('english', name)", using: :gin
  end
end
