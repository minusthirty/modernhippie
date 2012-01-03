class RemoveMetaDescriptionFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :meta_description
  end
end