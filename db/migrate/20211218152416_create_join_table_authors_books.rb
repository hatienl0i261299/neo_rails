# frozen_string_literal: true

class CreateJoinTableAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    create_join_table :authors, :books do |t|
      t.index %i[author_id book_id]
      t.index %i[book_id author_id]
    end
  end
end
