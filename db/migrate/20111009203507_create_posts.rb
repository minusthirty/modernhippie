class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :category_id
      t.string  :title
      t.text    :body
      t.string  :meta_description
      t.boolean :draft, :default => true
      t.integer :attachments_count,  :default => 0
      
      t.datetime :published_at
      t.timestamps
    end
  end
end
