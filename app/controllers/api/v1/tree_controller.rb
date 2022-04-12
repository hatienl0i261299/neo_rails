# frozen_string_literal: true

module Api
  module V1
    class TreeController < ApplicationController
      def index
        full_tree = Tree.all.order(id: :asc)
        tree_data = Tree.arrange_nodes(full_tree)
        render json: tree_data, adapter: nil, status: :ok
      end

      def show
        node_id = params[:id]
        node = Tree.find(node_id)
        asset = Tree.where(
          "
                ( trees.parent_path LIKE '#{node.parent_path.present? ? "#{node.parent_path}-" : ''}#{node_id}-%' OR
                trees.parent_path LIKE '#{node.parent_path.present? ? "#{node.parent_path}-" : ''}#{node_id}' ) OR
                trees.id = #{node_id}
            ".gsub(/\s+/, ' ')
        )
        tree = Tree.arrange_nodes(asset)
        render json: tree[0], adapter: nil, status: :ok
      end

      def update
        parent_tree = Tree.find(params[:id])
        name = params[:name]
        if Tree.find_by_name(name).present?
          return bad_request("#{ReasonError.new.validateError}Name has already been taken")
        end

        children = Tree.new(name: name)
        child = Tree.add_parent(parent_tree, children)
        if child
          render json: child, status: :ok
        else
          head :unprocessable_entity
        end
      end

      def children
        node_id = params[:node_id]
        tree = Tree.get_children(node_id)
        render json: tree, status: :ok
      end

      def full_parent
        node_id = params[:node_id]
        tree = Tree.find(node_id)
        parent_path = tree.parent_path
        output = [tree]
        if parent_path.present?
          lst_path = parent_path.split '-'
          output = Tree.find([lst_path]) + output
        end
        render json: output, status: :ok
      end

      def destroy
        node = Tree.find(params[:id])

        parent_path = node.parent_path
        all_children = Tree.where("
            trees.parent_path LIKE '#{parent_path.present? ? "#{parent_path}-" : ''}#{params[:id]}-%' OR
            trees.parent_path = '#{parent_path.present? ? "#{parent_path}-" : ''}#{params[:id]}'
        ".gsub(/\s+/, ' ')).order(id: :asc)

        # destroy: tất cả các node con cũng sẽ bị xóa bỏ
        # all_children.delete_all

        # rootify: Con của node bị phá hủy sẽ trở thành node gốc
        # for child in all_children
        #     new_path = child.parent_path.gsub(Regexp.new(".*?#{params[:id]}-?", Regexp::IGNORECASE | Regexp::MULTILINE), '')
        #     child.parent_path = !new_path.empty? ? new_path : nil
        #     child.save!
        # end

        # adopt: node con sẽ được thêm vào parent của node bị xóa
        all_children.each do |child|
          new_path = child.parent_path.split('-')
          new_path.delete params[:id]
          child.parent_path = new_path.empty? ? nil : new_path.join('-')
          child.save!
        end

        # restrict : thêm một exception nếu có node con tồn tại

        node.destroy!
        head :no_content
      end

      private

      def tree_params
        params.require(:tree).permit(:name)
      end
    end
  end
end
