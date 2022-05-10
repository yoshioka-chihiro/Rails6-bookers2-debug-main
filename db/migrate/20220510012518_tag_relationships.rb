class TagRelationships < ActiveRecord::Migration[6.1]
  def change
    drop_table :tag_relationships
  end
end
