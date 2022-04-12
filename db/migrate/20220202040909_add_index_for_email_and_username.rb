# frozen_string_literal: true

class AddIndexForEmailAndUsername < ActiveRecord::Migration[6.1]
  enable_extension 'plpgsql'
  enable_extension 'pg_trgm'
  enable_extension 'fuzzystrmatch'
  enable_extension 'btree_gin'
  # def change
  #   add_index :users, :email, using: :gist
  #   add_index :users, :username, using: :gist
  # end

  def up
    execute('CREATE INDEX index_users_on_email ON users (email text_pattern_ops)')
    execute('CREATE INDEX index_users_on_username ON users USING gist(username gist_trgm_ops)')
  end

  def down
    remove_index :users, :email
    remove_index :users, :username
  end
end
