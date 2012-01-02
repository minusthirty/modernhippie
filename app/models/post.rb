class Post < ActiveRecord::Base
  
  attr_accessor :delete_cover_image
  
  before_validation :update_cover_image
  before_save       :update_published_at
  
  belongs_to :category
  has_many :images, :dependent => :destroy, :order => 'created_at'
  
  accepts_nested_attributes_for :images, 
    :reject_if => lambda { |p| p[:photo].blank? },
    :allow_destroy => true
    
  validates_associated :images
  
  validates :category,  :presence => true
  validates :title,     :presence => true, :length => { :within => 3..40 }, :uniqueness => true
  validates :body,      :presence => true, :length => { :within => 1..2000 }
  
  validates_attachment_content_type :cover_image,
    :content_type => ['image/jpeg', 'image/pjpeg'],
    :message => "has to be in jpeg format"
    
  validates_attachment_size :cover_image, 
    :less_than => 2.megabytes, 
    :unless => Proc.new {|m| m[:cover_image].nil?}
  
  # square cover image
  has_attached_file :cover_image,
    {:styles => { :small    => ["50x50#", :jpg],
                  :medium   => ["150x150#", :jpg],
                  :large    => ["300x300#", :jpg]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
  
  private
    def update_published_at
      self.published_at = draft ? nil : Time.now
    end
  
    def update_cover_image
      self.cover_image.clear if delete_cover_image == '1'
    end
end
