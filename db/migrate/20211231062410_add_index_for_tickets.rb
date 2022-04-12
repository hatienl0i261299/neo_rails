# frozen_string_literal: true

class AddIndexForTickets < ActiveRecord::Migration[6.1]
  def change
    add_index :tickets, :match
  end
end
