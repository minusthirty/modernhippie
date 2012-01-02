class Image < ActiveRecord::Base
  
  belongs_to :post, :counter_cache => true, :touch => true
  
  validates_attachment_content_type :photo, 
    :content_type => ['image/jpeg', 'image/pjpeg'], 
    :message => "has to be in jpeg format"
    
  validates_attachment_size :photo, 
    :less_than => 2.megabytes, 
    :unless => Proc.new {|m| m[:photo].nil?}
  
  has_attached_file :photo,
    {:styles => { :admin_vertical   => ["122x165#", :jpg],
                  :admin_horizontal => ["250x165#", :jpg],
                  :vertical         => ["245x330#", :jpg],
                  :horizontal       => ["500x330#", :jpg]}
                  
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
 after_photo_post_process :store_exif
  
  # return image url for orientation
  # limit to either landscape or portrait
  def oriented_photo_url(prefix=nil)
    photo_style = self.orientation == 'horizontal' ? 'horizontal' : 'vertical'
    photo_style = "#{prefix.to_s}_#{photo_style}" if prefix
    self.photo.url(photo_style.to_sym)
  end
  
  private  
  def store_exif
    img_file = self.photo.queued_for_write[:original].path
    return unless img_file
    
    img_data = EXIFR::JPEG.new(img_file)
    return unless img_data
    
    aspect = img_data.width / img_data.height.to_f
    self.orientation = case 
      when aspect == 1 then 'square'
      when aspect > 1  then 'horizontal'
      when aspect < 1  then 'vertical'
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
