class Tree < ApplicationRecord
  belongs_to :root, class_name: 'Node', autosave: true
end
