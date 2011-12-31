class Post < ActiveRecord::Base
  
  attr_accessor :delete_image
  
  before_validation :delete_attachments
  before_save       :update_published_at
  
  belongs_to :category
  has_many :attachments, :dependent => :destroy
  
  accepts_nested_attributes_for :attachments,
    :reject_if => lambda { |p| p[:description].blank? },
    :allow_destroy => true
  
  validates_associated :attachments
  
  validates :category,  :presence => true
  validates :title,     :presence => true, :length => { :within => 3..40 }, :uniqueness => true
  validates :body,      :presence => true, :length => { :within => 1..1000 }
  
  has_attached_file :image,
    {:styles => { :small    => ["100x48#", :jpg],
                  :medium   => ["340x165#", :jpg],
                  :large    => ["700x340#", :jpg]}
    }.merge(PAPERCLIP_STORAGE_OPTIONS)
  
  private
    def update_published_at
      self.published_at = draft ? nil : Time.now
    end
  
    def delete_attachments
      self.image.clear if delete_image == '1'
    end
end
