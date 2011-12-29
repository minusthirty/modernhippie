class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :post_id
      t.string :description

      # paperclip
      t.string          :image_file_name, :image_content_type
      t.integer         :image_file_size
      t.datetime        :image_updated_at

      t.timestamps
    end
  end
end
