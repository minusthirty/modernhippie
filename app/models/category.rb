class Category < ActiveRecord::Base
  
  default_scope :order => "position"
  
  acts_as_list
  
  has_many :posts
  validates :name,  :presence   => true, 
                    :length     => { :within => 3..20 }, 
                    :uniqueness => true
  
end
