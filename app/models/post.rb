class Post < ActiveRecord::Base

  # only show published posts
  # use unscoped for admin index
  default_scope where('published_at is not null').order("created_at desc")
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
  attr_accessor :delete_cover_image
  
  before_validation :update_cover_image
  before_save       :update_published_at
  before_save       :update_body_html
  
  belongs_to :category
  has_many :images, :dependent => :destroy, :order => 'created_at'
  
  accepts_nested_attributes_for :images, 
    :reject_if => lambda {|i| i[:id].blank? && i[:photo].blank?},
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
  # double width square for rollover effect
  has_attached_file :cover_image,
    {:styles => { :small    => ["100x50#", :jpg],
                  :medium   => ["200x100#", :jpg],
                  :large    => ["490x245#", :jpg]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
  
  def older_post
    self.class.where("created_at < ?", created_at).first
  end

  def newer_post
    self.class.where("created_at > ?", created_at).last
  end
  
  def summary
    @summary ||= self.body.split(/\r\n/).first
  end
  
  private
    def update_body_html
      self.body_html = RedCloth.new(self.body).to_html
    end
  
    def update_published_at
      self.published_at = draft ? nil : Time.now
    end
  
    def update_cover_image
      self.cover_image.clear if delete_cover_image == '1'
    end
end
