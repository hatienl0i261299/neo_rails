# frozen_string_literal: true

module Api
  module V1
    class ArticleController < ApplicationController
      def index
        article = Article.includes(:genre).search(params[:query]).paging(params[:page], params[:per_page])

        puts article.analyze
        render json: article, status: :ok
      end
    end
  end
end
