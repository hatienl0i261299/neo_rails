# frozen_string_literal: true

class AddLockingColumnForNurse < ActiveRecord::Migration[6.1]
  def change
    add_column :nurses,
               :lock_version,
               :integer,
               default: 0,
               null: false
  end
end
