# frozen_string_literal: true

class StatusSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :active,
             :created_at,
             :updated_at
end
