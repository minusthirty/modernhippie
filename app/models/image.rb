class Image < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true, :touch => true

  validates_attachment_content_type :photo, 
    :content_type => ['image/jpeg', 'image/pjpeg'], 
    :message => "has to be in jpeg format"
  
  has_attached_file :photo,
    {:styles => { :square       => ["330x330#", :jpg],
                  :portrait     => ["245x330#", :jpg],
                  :landscape    => ["500x330#", :jpg]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
  before_photo_post_process :store_exif
  
  
  def oriented_photo_url(admin=false)
    photo_format = if admin
      "admin_#{self.orientation}".to_sym
    else
      self.orientation.to_sym
    end
    self.photo.url(photo_format)
  end
  
  private
  def store_exif
    img_file = self.photo.to_file
    return unless img_file
    
    img_data = EXIFR::JPEG.new(self.photo.to_file)
    return unless img_data
    
    aspect = img_data.width / img_data.height.to_f
    self.orientation = case 
      when aspect == 1 then 'square'
      when aspect > 1  then 'landscape'
      when aspect < 1  then 'portrait'
      else 
        nil
    end
    
    self.width          = img_data.width
    self.height         = img_data.height
    self.camera_model   = img_data.model
    self.taken_at       = img_data.date_time
    self.exposure_time  = img_data.exposure_time.to_s
    self.f_number       = img_data.f_number.to_f
    self.focal_length   = img_data.focal_length.to_s
  end
end
