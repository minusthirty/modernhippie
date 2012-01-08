class AddFeaturedToImages < ActiveRecord::Migration
  def change
    add_column :images, :featured, :boolean, :default => false
  end
end