class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :category_id
      
      t.string  :title
      t.text    :body
      t.string  :meta_description
      t.boolean :draft, :default => true
      t.integer :images_count,  :default => 0
      
      # paperclip
      t.string      :cover_image_file_name
      t.string      :cover_image_content_type
      t.integer     :cover_image_file_size
      t.datetime    :cover_image_updated_at
      
      t.datetime :published_at
      t.timestamps
    end
  end
end
