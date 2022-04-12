# frozen_string_literal: true

# MessageSerializer
class MessageSerializer < ApplicationSerializer
  attributes :id,
             :content,
             :read,
             :user,
             :status,
             :created_at,
             :updated_at

  def status
    object.user.status
  end

  def user
    UserSerializer.new(object.user).serializable_hash
  end
end
