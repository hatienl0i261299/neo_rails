# frozen_string_literal: true

class BookSerializer < ApplicationSerializer
  attributes :id, :title, :content, :created_at, :updated_at, :authors

  # def authors
  #   object.authors.order(id: :asc)
  # end
end
