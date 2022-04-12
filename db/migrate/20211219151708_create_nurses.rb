# frozen_string_literal: true

class CreateNurses < ActiveRecord::Migration[6.1]
  def change
    create_table :nurses do |t|
      t.string :name
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end
end
