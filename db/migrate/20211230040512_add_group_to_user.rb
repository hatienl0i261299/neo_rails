# frozen_string_literal: true

class AddGroupToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :group, null: false, foreign_key: true
  end
end
