class Story < ActiveRecord::Base
  attr_accessible :name, :user_id
  
  belongs_to :user
  
  has_many :favourites
  
  validates_presence_of :name
  
  default_scope order("created_at desc")
end
