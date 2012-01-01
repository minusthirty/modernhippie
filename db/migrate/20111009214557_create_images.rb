class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :post_id

      # paperclip
      t.string      :photo_file_name
      t.string      :photo_content_type
      t.integer     :photo_file_size
      t.datetime    :photo_updated_at

      #exit
      t.integer   :width, :height 
      t.string    :camera_model, :exposure_time, :focal_length
      t.float     :f_number
      t.datetime  :taken_at
      t.string    :orientation

      t.timestamps
    end
  end
end
