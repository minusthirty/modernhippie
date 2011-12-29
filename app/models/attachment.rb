class Attachment < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true, :touch => true
  
  has_attached_file :image,
    {:styles => { :small => ["30x30#", :jpg],
                  :medium => ["60x60#", :jpg],
                  :large => ["180x180#"]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
end
