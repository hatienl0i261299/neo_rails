# frozen_string_literal: true

class AddTicketBelongToUser < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :users, :tickets
  end
end
