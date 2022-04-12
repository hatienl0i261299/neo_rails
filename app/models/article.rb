# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :genre

  include PgSearch::Model
  pg_search_scope :pg_search,
                  against: :title,
                  using: { tsearch: { dictionary: 'english' } },
                  associated_against: { genre: :name }

  scope :search, lambda { |query|
    return all unless query.present?

    # joins(:genre).where("to_tsvector('english', title) @@ plainto_tsquery('english', :q)", q: query)
    #              .or(Article.where("to_tsvector('english', genres.name) @@ plainto_tsquery('english', :q)", q: query))

    # joins(:genre).where("to_tsvector('english', genres.name) @@ plainto_tsquery('english', :q)", q: query)

    pg_search(query)
  }
end
