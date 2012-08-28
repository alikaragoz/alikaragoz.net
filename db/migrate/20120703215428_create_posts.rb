class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body
      t.string :slug
      t.boolean :status
      t.string :title
      t.timestamps
    end
    
    add_index "posts", ["slug"], :name => "posts_slug_index", :unique => true
  end
end
