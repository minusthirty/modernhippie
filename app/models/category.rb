class Category < ActiveRecord::Base
  
  has_many :posts
  validates :name,  :presence   => true, 
                    :length     => { :within => 3..20 }, 
                    :uniqueness => true
  
end
