class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes do |t|
      t.references :parent_node
      t.string :text

      t.timestamps
    end
  end
end
