class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer  "post_id"
      t.integer  "tag_id"
      t.timestamps
    end
    
    add_index(:taggings, :post_id, :name => "taggings_post_id_index")
    add_index(:taggings, :tag_id, :name => "taggings_tag_id_index")
  end
end
