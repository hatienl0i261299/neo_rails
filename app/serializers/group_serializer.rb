# frozen_string_literal: true

class GroupSerializer < ApplicationSerializer
  attributes :id, :group_role, :group_name, :roles, :created_at, :updated_at
end
