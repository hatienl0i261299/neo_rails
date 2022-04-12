# frozen_string_literal: true

class AuthorSerializer < ApplicationSerializer
  attributes :id, :name, :created_at, :updated_at, :books

  def books
    object.books
  end
end
