class Attachment < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true, :touch => true
  
  has_attached_file :image,
    {:styles => { :small  => ["170x83#", :jpg],
                  :medium => ["340x165#", :jpg],
                  :large  => ["700x340#", :jpg]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
end
