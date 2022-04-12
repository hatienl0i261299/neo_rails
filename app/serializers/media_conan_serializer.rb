# frozen_string_literal: true

class MediaConanSerializer < ApplicationSerializer
  attributes :id,
             :character,
             :gadget,
             :vehicle,
             :tree,
             :avatar,
             :created_at,
             :updated_at

  def avatar
    object.avatar.blob
  end
end
