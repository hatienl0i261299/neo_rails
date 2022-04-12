# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class LolChampionController < ApplicationController
      def index
        lol_champion = LolChampion
                       .paging(params[:page], params[:per_page])
                       .includes(:tree, avatar_attachment: [:blob])
                       .order(updated_at: :desc)
        render json: {
          **pagination(lol_champion),
          data: lol_champion.map { |item| LolChampionSerializer.new(item).serializable_hash }
        }, status: :ok
      end

      def create
        lol = LolChampion.create! name: params[:name],
                                  location: params[:location],
                                  quote: params[:quote],
                                  summoner_spell: params[:summoner_spell],
                                  tree_id: params[:tree_id],
                                  avatar: params[:avatar]

        render json: lol, status: :ok
      end

      def show
        render json: LolChampion.find(params[:id]), status: :ok
      end

      def download_avatar
        storage_blob = ActiveStorage::Blob.find(params[:id_storage_blob])

        send_data storage_blob.download, type: storage_blob.content_type, file_name: storage_blob.filename
      end
    end
  end
end
