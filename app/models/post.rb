class Post < ActiveRecord::Base
  
  attr_accessor :delete_attachment
  
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
  
  def cover(size=:small)
    return "" if attachments.empty?
    return "" unless attachments.first.image
    attachments.first.image.url(size)
  end
  
  private
    def update_published_at
      self.published_at = draft ? nil : Time.now
    end
  
    def delete_attachments
      self.attachments.clear if delete_attachment == '1'
    end
end
