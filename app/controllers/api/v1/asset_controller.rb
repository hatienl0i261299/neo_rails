# frozen_string_literal: true

module Api
  module V1
    class AssetController < ApplicationController
      def index
        node_id = params[:asset_id]
        node = Asset.find(node_id)
        asset = Asset.where(
          "( assets.ancestry LIKE '#{node.ancestry}/#{node_id}/%' OR " \
          "assets.ancestry LIKE '#{node.ancestry}/#{node_id}' ) OR " \
          "assets.id = #{node_id}"
        )
        tree = Asset.arrange_nodes(asset)
        render json: tree, status: :ok
      end

      def show
        # asset = Asset.find(params[:id]).children
        # asset = Asset.find(params[:id]).path
        # asset = Asset.find(params[:id]).root
        asset = Asset.arrange_serializable
        render json: asset, status: :ok
      end

      def destroy
        asset = Asset.find(params[:id])
        if asset.destroy!
          head :no_content
        else
          head :unprocessable_entity
        end
      end
    end
  end
end
