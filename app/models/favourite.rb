class Favourite < ActiveRecord::Base
  attr_accessible :story_id, :user_id
  
  belongs_to :story
  belongs_to :user
  
  validates_presence_of :story_id, :user_id
  
  default_scope order("created_at desc")
end
