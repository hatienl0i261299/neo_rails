# frozen_string_literal: true

class RemoveUserRoleAndCreateGroupRole < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :users, :roles

    create_join_table :groups, :roles do |t|
    end
  end
end
