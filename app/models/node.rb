class Node < ApplicationRecord
  belongs_to :parent_node, class_name: 'Node', optional: true, inverse_of: :children
  has_many :children, class_name: 'Node', foreign_key: :parent_node_id, inverse_of: :parent_node, autosave: true
end
