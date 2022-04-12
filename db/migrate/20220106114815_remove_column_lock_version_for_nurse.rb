# frozen_string_literal: true

class RemoveColumnLockVersionForNurse < ActiveRecord::Migration[6.1]
  def change
    remove_column :nurses, :lock_version
  end
end
