# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class BookController < ApplicationController
      def index
        books = Book.paging(params[:page], params[:per_page]).order(updated_at: :desc).preload(:authors)
        render json: {
          **pagination(books),
          data: books.map { |item| BookSerializer.new(item).serializable_hash }
        }, status: :ok
      end

      def show
        book = Book.find(params[:id])

        a = 'https://zingmp3.vn/video-clip/Yeu-Nhieu-Ghen-Nhieu-Thanh-Hung/123.html, https://zingmp3.vn/video-clip/Yeu-Nhieu-Ghen-Nhieu-Thanh-Hung/456.html'
        mobj = a.scan(Regexp.new('\/((?:bai-hat|video-clip))\/(.*?)\/(.*?)\W', Regexp::IGNORECASE | Regexp::MULTILINE))
        mobj.map do |_type, _slug, id|
          puts id
        end

        render json: book, status: :ok
      end

      def bulk_update
        items = params[:_json]

        items.map do |item|
          data = item[:data].as_json
          Book.find(item[:id]).update!(**data)
        end

        head :no_content
      end

      def destroy
        Book.find(params[:id]).destroy!
        head :no_content
      end
    end
  end
end
