# frozen_string_literal: true

class TicketSerializer < ApplicationSerializer
  attributes :id,
             :area,
             :match,
             :user_id,
             :user,
             :created_at,
             :updated_at

  def user
    {
      full_name: "#{object.user.first_name} #{object.user.last_name}",
      email: object.user.email,
      active: object.user.status.active
    }
  end
end
