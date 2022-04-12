# frozen_string_literal: true

class Tree < ApplicationRecord
  has_many :lol_champions, dependent: :nullify
  has_many :media_conans, dependent: :nullify
  has_many :media_one_pieces, dependent: :nullify
  has_many :pokemon_pets, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  # format: { with: Regexp.new('(?:abcdef|ghiklm)'), message: 'invalid name' }

  scope :get_children, lambda { |node_id|
    where("trees.parent_path = '#{node_id}' OR trees.parent_path LIKE '%-#{node_id}'")
  }

  def self.add_parent(parent_model, children)
    children.parent_path = if parent_model.parent_path.present?
                             "#{parent_model.parent_path}-#{parent_model.id}"
                           else
                             parent_model.id
                           end
    if children.save!
      children
    else
      false
    end
  end

  def self.json_tree(nodes)
    nodes.map do |node, sub_nodes|
      {
        **TreeSerializer.new(node).serializable_hash,
        children: json_tree(sub_nodes)
      }
    end
  end

  def self.arrange_nodes(nodes)
    node_ids = nodes.map(&:id)
    index = Hash.new { |h, k| h[k] = {} }
    json_tree(nodes.each_with_object({}) do |node, arranged|
      parent_id = node.parent_path.present? ? node.parent_path.split('-')[-1].to_i : nil
      children = index[node.id]
      index[parent_id][node] = children
      arranged[node] = children unless node_ids.include?(parent_id)
    end)
  end
end
