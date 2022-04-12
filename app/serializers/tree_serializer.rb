# frozen_string_literal: true

class TreeSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :created_at,
             :updated_at
end
