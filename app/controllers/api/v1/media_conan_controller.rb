# frozen_string_literal: true

require_relative '../../../../common/helper'
module Api
  module V1
    class MediaConanController < ApplicationController
      def index
        media_conan = MediaConan
                      .paging(params[:page], params[:per_page])
                      .includes(:tree, avatar_attachment: [:blob])
                      .order(updated_at: :desc)

        render json: {
          **pagination(media_conan),
          data: media_conan.map { |item| MediaConanSerializer.new(item).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def show
        render json: MediaConan.includes(:tree).find(params[:id]), status: :ok
      end

      def download_avatar
        storage_blob = ActiveStorage::Blob.find(params[:id_storage_blob])
        # width = str_to_int(params[:width])
        # height = str_to_int(params[:height])
        # if width.present? && height.present?
        #   new_blob = storage_blob.representation(resize_to_limit: [width, height]).processed
        #   send_data new_blob.download, type: storage_blob.content_type
        # else
        # end
        send_data storage_blob.download, type: storage_blob.content_type, file_name: storage_blob.filename
      end

      def create
        media_conan = MediaConan.create! character: params[:character],
                                         gadget: params[:gadget],
                                         vehicle: params[:vehicle],
                                         tree_id: params[:tree_id],
                                         avatar: params[:avatar]

        render json: media_conan, status: :ok
      end

      def update
        media_conan = MediaConan.find(params[:id]).update! character: params[:character],
                                                           gadget: params[:gadget],
                                                           vehicle: params[:vehicle],
                                                           tree_id: params[:tree_id],
                                                           avatar: params[:avatar]

        render json: media_conan, status: :ok
      end

      def destroy
        media_conan = MediaConan.find(params[:id])
        media_conan.destroy!
        head :no_content
      end
    end
  end
end
