# frozen_string_literal: true

require_relative '20211219093110_add_ticket_belong_to_user'
require_relative '20211219092552_create_tickets'

class UpdateTicketTable < ActiveRecord::Migration[6.1]
  def change
    revert AddTicketBelongToUser
    revert CreateTickets
    create_table :tickets do |t|
      t.string :area
      t.string :match
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
