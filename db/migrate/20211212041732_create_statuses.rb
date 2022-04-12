# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :statuses do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
